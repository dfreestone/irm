%ADD_MEASURE adds a measure from the measures list.
%
% Syntax
% ------
%   sim.add_measure({measure_name, measure_expression});
%
% Details
% -------
% You can enter a nx2 cell of measure names (column 1) and expressions
% (column 2).
%
% Examples
% --------
%  
% See also: simulate.edit_measure, simulate.remove_measure

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 2:02:00 $

function add_measure( sim, measure )

n = size( measure, 1 );
for i = 1 : n
    f = strcmpi( sim.measures(:,1), measure{i,1});
    if ~any( f )
        sim.measures(end+1,:) = measure(i,:);
    end % any
end % i

end    % add measure
