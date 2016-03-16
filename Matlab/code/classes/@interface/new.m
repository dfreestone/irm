%NEW clears the current simulation, launches a new one, and loads it into
%the interface.
%
% Syntax
% ------
%  ui.new();
%
% Details
% -------
% 
% 
% Examples
% --------
%  
% See also: interface.file_menu, interface.save, interface.open

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function new(ui)

ui.message_center( 'g', 'Creating graphic fields...' );
gr = ui.CreateUIGraphics();

ui.message_center( 'g', 'Initializing simulation...' );
sim = simulate();
sim.get_samples;

assignin( 'base', 'sim', sim ); % throw to base workspace
assignin( 'base', 'gr' , gr );  % throw to base workspace

ui.populate_lists(sim,gr);
ui.update_axes(sim,gr);

ui.message_center( 'g', 'Welcome. Click a small axis to get started.' );

ui.WriteLog('IRM:New', 'New simulation created.')

end % new