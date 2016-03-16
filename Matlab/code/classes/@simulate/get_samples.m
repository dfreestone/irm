%GET_SAMPLES creates the random samples.
%
% Syntax
% ------
%   sim.get_samples();
%
% Details
% -------
% Iterates over sim.Input for each set of parameter values, and returns
% corrosponding random samples from the correlation coefficient distribution.
%
% Examples
% --------
%
% See also: simulate.modify_input, simulate.get_varied,
% simulate.sample_precision, simulate.compute, simulate.compute_correlation

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 2:02:00 $

function get_samples(sim)

input = sim.Input;

n = cellfun( 'length', input );
n(:,1) = 1; % cuz...these are names.
ind = find( n > 1 );

switch length(ind)
    case 0
        sz = size( input{7} );
    case 1
        sz = size( input{ind} );
    case 2
        [input{ind(1)}, input{ind(2)}] = meshgrid( input{ind(1)}, input{ind(2)} );
        sz = size( input{ind(1)} ); % get the size of one of them.
    otherwise
       error('IRM:TooManyInputsVaried','Cannot vary more than two inputs.');
end % switch

issc = cellfun( @isscalar, input );
input(issc) = cellfun( @(x) x*ones(sz), input(issc), 'Unif', 0 );

try
    sim.randomsamples = repmat( {nan([sim.npoints,6])}, sz );
catch me
    error( 'IRM:SimSizeTooBig', 'Simulation too large, try a smaller simulation.' );
end

for i = 1 : sz(1)
    for j = 1 : sz(2)
        for k = 2 : 6
            r = sim.rrand( input{k,2}(i,j), input{k,3}(i,j), sim.npoints, sim.dr, sim.r );
            n = length(r);
            sim.randomsamples{i,j}(1:n,k) = r;
            sim.progress = sim.progress + 1;
        end % k
        sim.randomsamples{i,j}(:,1) = 1;
        rmv = any( isnan(sim.randomsamples{i,j}),2);
        sim.randomsamples{i,j}(rmv,:) = [];
    end % j
end % i

end               % getSamples
