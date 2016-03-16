%MODIFY_INPUT changes the input parameters for one or more input measures.
%
% Syntax
% ------
%   sim.modify_input({measure_name, rho, N});
%
% Details
% -------
% You can enter a nx3 cell of measure names (column 1) and rho values
% (column 2) and N values (column 3).
%
% Examples
% --------
%
% See also: simulate.get_samples, simulate.get_varied

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 2:02:00 $

function modify_input( sim, measure )

input = sim.Input;
n = size( measure, 1 );
for i = 1 : n
    f = strcmpi( measure(i,1), sim.Input(:,1) );
    input(f,:) = measure(i,:);
end % i

inputsvaried = cellfun( @length, input ) > 1;
inputsvaried(:,1) = 0;
n = sum(inputsvaried(:));
if n > 2
    error( 'IRM:MoreThanTwoInputsModified', 'Cannot vary more than two inputs.' );
end % n > 2

sim.inputsVaried = inputsvaried;
sim.Input        = input;

end   % modifyInput
