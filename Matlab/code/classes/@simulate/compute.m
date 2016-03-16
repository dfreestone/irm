%COMPUTE computes the measure specified
%
% Syntax
% ------
%   y = sim.compute(measure_name);
%   y = sim.compute(measure_name,row,col);
%
%
% Details
% -------
% y = sim.compute(measure_name);
%   computes the measure specified by measure. y is a cell matrix the same size
%   as sim.randomsamples.
%
% y = sim.compute(measure_name,row,col);
%   only computes the measure on the specified rows and columns of
%   sim.randomsamples. The output is a cell matrix the same size as
%   [length(rows),length(cols)]
%
% Examples
% --------
%
%
% See also: cell2mat, simulate.compute, simulate.get_samples, sim.add_measure,
%sim.edit_measure, sim.remove_measure

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 2:02:00 $

function result = compute(sim,measure,varargin)

func = sim.ConvertMeasure( measure );

if ~ishandle(func), func = str2func( strcat('@(r)', func) ); end

% User can input rows and cols to compute
if isempty(varargin)
    [nr,nc] = size( sim.randomsamples );
    rows = 1 : nr;
    cols = 1 : nc;
else
    [rows, cols] = deal(varargin{:});
    nr = length(rows);
    nc = length(cols);
end

% And now...to compute!
result = cell([nr,nc]);
for i = 1 : nr
    for j = 1 : nc
        result{i,j} = func( sim.randomsamples{rows(i),cols(j)} );
    end
end

if sim.correlation_inputchk(measure)
    result = FormatCorrelations(result);
    return
end

end % sim

function result = FormatCorrelations(y)

vals = logical(triu(ones(size(y{1})),1)); % but triu isn't defined on 3d matrices...
y = cellfun( @(x,y) x(y), y, repmat({vals},size(y)), 'Unif', 0 );


n_corr = length( y{1} ); % get number of correlations
[nr,nc] = size(y);       % and number of simulation combinations

if nr < 2 % only 1 thing was varied.
    y = cat(2,y{:})';
else % nr < 2
    if n_corr < 2 % 1 correlation requested.
        y = cell2mat( y );
    else % more than 1 requested
        % can probably use a combination of reshape, cell2mat, mat2cell, cellfun...
        % but i'll just do for loops
        c = y;
        y = cell( [1,n_corr] );
        for i = 1 : n_corr
            for j = 1 : nr
                for k = 1 : nc
                    y{i}(j,k) = c{j,k}(i);
                end % k
            end % j
        end % i
    end % n_corr > 1           % Hows this for a wall of ends? :p
end % nr < 2
result = {y};

end % FormatCorrelations

