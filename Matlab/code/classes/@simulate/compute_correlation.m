%COMPUTE_CORRELATION computes pearson's r for a list of measures.
%
% Syntax
% ------
%   c = sim.compute_correlation(measure_name);
%   c = sim.compute_correlation(measure_name,row,col);
%
% 
% Details
% -------
% c = sim.compute_correlation(measure_name);
%   computes the correlation matrix on measure_name and returns a double
%   precision matrix the same size as sim.randomsamples
%
% c = sim.compute_correlation(measure_name, row, col);
%   only computes the correlation on the specified rows and columns of
%   sim.randomsamples. The output is the same size as 
%   [length(rows),length(cols)]
%
% Examples
% --------
%  
% See also: simulate.compute, simulate.get_samples, sim.add_measure, 
%sim.edit_measure, sim.remove_measure

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 2:02:00 $
function result = compute_correlation( sim, measure, varargin )

measure = sim.ConvertMeasure( measure );
if isempty( strfind( measure, 'corrcoef' ) )
    measure = sprintf( 'corrcoef(%s)', measure );
end

y = sim.compute( measure, varargin );

% only the upper triangle matters...
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
result = y;
end % compute_correlation
