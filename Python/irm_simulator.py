__author__ = 'davidfreestone'


import numpy as np
from copy import deepcopy
import correlation_coefficient as cc

class simulator:

    def __init__(self, sample_precision=1e-4, nsamples=1e4, maximum_size=500):
        self.sample_precision = sample_precision
        self.nsamples = nsamples
        self.maximum_size = maximum_size

        nstep = 1 + 2*(1/sample_precision)
        self.r = np.linspace(-1, 1, nstep)

        self.samples = np.empty([])
        self.irm_matrix = self.default_matrix()

        self.measures = {'Self-Enhancement'       : 'r(s,d) - r(i,d)',
                         'Differential Accuracy'  : 'r(i,<i>) - r(o,<o>)',
                         'Ingroup Favoritism'     : 'r(i,d) - r(o,d)',
                         'Intergroup Accentuation': 'r(i,o)'}

        self.names_irmmatrix = np.array([
            ['r(s,s)',  'r(s,d)',  'r(s,i)',  'r(s,o)',  'r(s,<i>)'  ,  'r(s,<o>)'],
            ['-'     ,  'r(d,d)',  'r(i,d)',  'r(o,d)',  'r(d,<i>)'  ,  'r(d,<o>)'],
            ['-'     ,  '-'     ,  'r(i,i)',  'r(i,o)',  'r(i,<i>)'  ,  'r(i,<o>)'],
            ['-'     ,  '-'     ,  '-'     ,  'r(o,o)',  'r(o,<i>)'  ,  'r(o,<o>)'],
            ['-'     ,  '-'     ,  '-'     ,  '-'     ,  'r(<i>,<i>)',  'r(<i>,<o>)'],
            ['-'     ,  '-'     ,  '-'     ,  '-'     ,  '-'         ,  'r(<o>,<o>)']])


    def add_measure(self, measure):
        """Add measure to measures list"""
        self.measures.update(measure)

    def remove_measure(self, measure):
        """Remove an existing key"""
        if measure not in self.measures:
            return
        del self.measures[measure]

    def modify_parameters(self, d):
        """Modify the parameters the simulation will use"""
        for key in d:
            self.irm_matrix[key].update(d[key])

    def compute(self, measure):
        """Return the computed the input measure"""
        # TODO(David): If deploying on a server, must make eval foolproof
        expression = self.convert_measure(measure)
        return eval(expression)

    def correlate(self, measure1, measure2):
        """Return the correlation matrix of 2 computed measures"""
        nk, nr, nc, ns = self.samples.shape
        x = self.compute(measure1)
        y = self.compute(measure2)
        cov = np.empty((nr, nc))
        for r in range(nr):
            for c in range(nc):
                cov[r,c] = np.corrcoef(x[r,c,], y[r,c,])[0,1]
        return cov

    def convert_measure(self, measure):
        """Convert a complex measure to the form used in computations"""
        while _items_remaining(self.measures, measure):
            for key in self.measures:
                measure = measure.replace(key, "({})".format(self.measures[key]))

        # reduce the complex measures to primary measures
        derived = _derived_measures(self.names_irmmatrix)
        for key in derived:
            measure = measure.replace(key, "({})".format(derived[key]))

        # create an eval string.
        for key in self.irm_matrix:
            measure = measure.replace(key, "self.samples[{},]".format(self.irm_matrix[key]['position']))
        return measure

    def default_matrix(self):
        """Return a dictionary of default values for each parameter"""
        names = ['r(s,s)', 'r(s,d)', 'r(s,i)', 'r(s,o)', 'r(s,<i>)', 'r(s,<o>)']
        rho = np.array([1., 0.5, 0.5, 0.0, 0.5, 0.0])
        N = np.array([26] * 6)
        irm_matrix = {}
        for pos, (name, r, n) in enumerate(zip(names, rho, N)):
            irm_matrix[name] = {'rho': r, 'N': n, 'position': pos}
        return irm_matrix

    def simulate(self):
        """Create samples based on the irm_matrix specifications"""
        nr, nc, nk = _simulation_shape(self.irm_matrix)
        ns = self.nsamples
        expectedsize = _expected_megabytes(nk, nr, nc, ns)
        if expectedsize > self.maximum_size:
            return
        self.samples = np.empty((nk, nr, nc, ns))
        for pos, row, col, rho, N in _iterable_matrix(self.irm_matrix):
            self.samples[pos, row, col, :] = cc.rrand(self.r, rho, N, ns)

    def axes_info(self):
        """Return dictionary that specifies whats on the x and y axes
            It gives what variable is varied along the 2nd and 3rd dimensions
            in samples.
        """
        _, rho, N = _dict2list(self.irm_matrix)

        nvars = len(self.irm_matrix)
        varname = np.array(list(self.irm_matrix.keys()) * 2)
        paramname = np.array([['rho']*nvars, ['N']*nvars]).ravel()
        varied = np.hstack((np.array([r.size for r in rho])>1,
                            np.array([n.size for n in N])>1))

        varied_varnames = varname[varied]
        varied_param = paramname[varied]

        axesinfo = {}
        nvaried = varied.sum()
        if nvaried == 0:
            axesinfo['row'] = None
            axesinfo['col'] = None
        elif nvaried == 1:
            axesinfo['row'] = {'name': varied_varnames[0], 'param': varied_param[0]}
            axesinfo['col'] = None
        elif nvaried == 2:
            axesinfo['row'] = {'name': varied_varnames[0], 'param': varied_param[0]}
            axesinfo['col'] = {'name': varied_varnames[1], 'param': varied_param[1]}
        elif nvaried > 2:
            raise ValueError('Varying too many things')
        return axesinfo

    def swap_axes(self, d, x):
        """Transpose the data and return the new axes information"""
        d['row'], d['col'] = d['col'], d['row']
        return d, x.T



# Helper functions below...
def _items_remaining(measures, v):
    """Return whether there are more measures to process
        Used when converting a complex measure to the primary measure
        Checks the complex measure the user entered to see if there's more
        items to process.
    """
    for key in measures:
        if key in v:
            return True
    return False

def _derived_measures(inmat):
    """Return a dictionary in which the keys are the derived measures and the
        values gives their composition
    """
    d = {}
    n = len(inmat)
    for i in range(1,n):
        for j in range(i+1,n):
            d[inmat[i,j]] = "{} * {}".format(inmat[0,i], inmat[0,j])
    return d

def _expected_megabytes(nr, nc, nd, ns):
    """Return the expected memory usage for a 4d matrix"""
    return (nr * nc * nd * ns * 8)/1000/1000


def _dict2list(irm_matrix):
    """Return pos, rho, and N as matching lists from the dict"""
    pos, rho, N = [], [], []
    for key in irm_matrix:
        pos.append(irm_matrix[key]['position'])
        rho.append(irm_matrix[key]['rho'])
        N.append(irm_matrix[key]['N'])
    return pos, rho, N

def _simulation_shape(irm_matrix):
    """Return the shape (2nd and 3rd dimension) of the simulation"""
    pos, rho, N = _dict2list(irm_matrix)
    shape = []
    for r, n in zip(rho, N):
        if r.size>1:
            shape.append(r.size)
        if n.size>1:
            shape.append(n.size)
    if not shape:
        shape = [1, 1]
    elif len(shape)==1:
        shape.append(1)
    elif len(shape)>2:
        raise ValueError
    shape.append(len(irm_matrix))
    return tuple(shape)


def _iterable_matrix(irm_matrix):
    """Return an iterable object that gives the rho and N for each simulation
        and the coordinates for how to put it in the samples matrix.

        Current algorithm works by creating lists of the parameters for each
        correlation in the irm_matrix. Using meshgrid to get all the
        combinations (keeping the coordinates in order), and then reshaping
        into a single column after.
    """
    # create initial lists
    pos, rho, N = _dict2list(irm_matrix)

    # combine the parameters, meshgrid, then prettify
    params = deepcopy(rho)
    params.extend(N)
    params = np.meshgrid(*params)
    params = [np.array(p).squeeze() for p in params]

    # split parameter list back up
    n = len(rho)
    rho, N = params[:n], params[n:]

    # now get the matching coordinates
    nr, nc, nk = _simulation_shape(irm_matrix)
    pos = [np.tile(p, (nr, nc)) for p in pos]

    NR, NC = np.meshgrid(range(nr), range(nc))
    row = [NR for _ in range(n)]
    col = [NC for _ in range(n)]

    def ravel(x): # syntacic sugar
        return np.array(x).ravel()

    return zip(ravel(pos), ravel(row), ravel(col), ravel(rho), ravel(N))