%REMOVE_MEASURE removes a measure from the measures list.
% 
% Syntax
% ------
%   sim.remove_measure(measure_name);
%
% Details
% -------
% You can enter a nx2 cell of measure names (column 1) and expressions
% (column 2).
%
% Examples
% --------
%  
% See also: simulate.add_measure, simulate.edit_measure

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 2:02:00 $

function remove_measure( sim, measure )

n = size( measure, 1 );
for i = 1 : n
    f = strcmpi( sim.measures(:,1), measure{i,1});
    if any( f )
        sim.measures(f,:) = [];
    end % any
end % i

end % remove measure
