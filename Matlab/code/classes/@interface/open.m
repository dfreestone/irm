%OPEN loads a previously saved simulation into the workspace and interface.
%
% Syntax
% ------
%  ui.open();
%
% Details
% -------
% This function loads a previously saved simulation into the workspace and
% interface window. It also loads user-defined measures and plot types into
% the interface.
% 
% Examples
% --------
%  
% See also: interface.file_menu, interface.save, interface.new,
% simulate.load

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function open(ui)

[sim,gr] = ui.CallSimulationAndGraphObjects();

sim.load();

fullname = fullfile(sim.savePath, saveName);
load(fullname, 'uiplotlist');

ui.update_axes( sim, gr ); %redraw axes
ui.populate_lists( sim, gr);
set(ui.handles.plots_listbox, 'String', uiplotlist);
ui.message_center( 'g', 'Simulation loaded.' );

end