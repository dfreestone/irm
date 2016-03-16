__author__ = 'davidfreestone'

# TODO(David): This might be easy to put into Cython

import numpy as np
from scipy.special import gamma

def rrand(r, rho, N, size=1):
    if np.abs(rho)>=1:
        return np.ones(size)

    y = rcdf(r, rho, N)
    u = np.random.rand(size)
    idx = np.searchsorted(y, u)
    return r[idx[idx.nonzero()[0]]]

def rcdf(r, rho, N):
    y = rpdf(r, rho, N).cumsum()
    return y / y[-1]

def rpdf(r, rho, N):
    return (  gamma( N-1 ) / gamma(N-0.5)                   # gamma ratio
            * (N-2) / np.sqrt(2*np.pi)                      # k ratio
            * hgeom(0.5, 0.5, N-0.5, (1+rho*r)/2, 1e-15)    # hgeom
            * (1 - rho**2)**((N-1)/2)                       # rho_ratio...
            * (1 - r**2)**((N-4)/2)                         # ...
            * (1 - rho*r)**((3/2) - N)                      # end rho_ratio
           )


def hgeom(a, b, c, z, tol):
    C = np.ones_like(z)
    F = np.ones_like(z)

    mxz = np.argmax(z) # max of z will be hardest to reject (CHECK THIS)

    tolChecksComplete = 0
    j = 0
    while tolChecksComplete < 3:
        C *= (((a+j)*(b+j)) / (c+j)) * z/(j+1)
        check = C[mxz] / F[mxz]

        if check < tol:
            tolChecksComplete+= 1

        F+= C
        j+= 1
    return F