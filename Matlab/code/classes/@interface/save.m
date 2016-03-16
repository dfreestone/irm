%SAVE saves the current simulation andlist of custom measures and plots 
% to a path specified by the user.
%
% Syntax
% ------
%  ui.save( sim, overwrite );
%
% Details
% -------
%  Calls the save function in the simulation object, sim.save. If overwrite
%  is sent in, the function will save the file automatically without
%  prompting for a new filename and path.
% 
% Examples
% --------
%  
% See also: interface.file_menu, interface.open, interface.new,
% simulate.save

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function save(ui, sim, overwrite)

if nargin==2, overwrite = true; end

sim.save( overwrite );

name = sim.saveName;
path = sim.savePath;

uiplotlist = get(ui.handles.plots_listbox, 'String'); %#ok<NASGU>

save([path name], '-append', 'uiplotlist');

ui.message_center( 'g', 'Simulation saved.');
ui.WriteLog('IRM:UISave', 'Simulation saved.');

end % save