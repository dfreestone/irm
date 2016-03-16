%CLICK highlights and displays the currently selected object when the user 
% selects a new one.
%
% Syntax
% ------
%  ui.click();
%
% Details
% -------
% This function is responsible for highlighting the currently selected
% measure and displaying it on the large axes display.
% 
% Examples
% --------
%  
% See also: interface.GetHandles, interface.SetCallbacks

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:36:00 $   

function click(varargin)

ui = varargin{1};
ax = get( ui.uihandle, 'CurrentAxes' );

[sim,gr] = ui.CallSimulationAndGraphObjects();

m = sim.irm_matrix();
[r,c] = find( ui.handles.input_axes == ax );

ui.currentlyActiveInput = m{r,c};
ui.message_center( 'g', 'Updating graphics...' );
ui.UpdateModifyInput(sim,gr);

end                 % click
