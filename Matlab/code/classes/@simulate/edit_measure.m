%EDIT_MEASURE edits a measure from the measures list.
%
% Syntax
% ------
%   sim.edit_measure({measure_name, measure_expression});
%
% Details
% -------
% You can enter a nx2 cell of measure names (column 1) and expressions
% (column 2).
%
% Examples
% --------
%  
% See also: simulate.add_measure, simulate.remove_measure

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 2:02:00 $

function edit_measure( sim, measure )

n = size( measure, 1 );
for i = 1 : n
    f = strcmpi( sim.measures(:,1), measure{i,1});
    if any( f )
        sim.measures(f,:) = measure(i,:);
    end % any
end % i

end   % edit measure
