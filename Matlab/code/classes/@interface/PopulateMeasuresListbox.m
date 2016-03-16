%POPULATEMEASURESLISTBOX adds the measures stored in the current simulation
% to the list of available user-defined measures.
%
% Syntax
% ------
%  ui.PopulateMeasuresListbox( sim );
%
% Details
% -------
% Responsible specifically for populating the user-defined measures
% listbox.
% 
% Examples
% --------
%  
% See also: interface.populate_lists, interface.PopulatePlotsListbox,
% interface.PopulatePlottypesDropdown, interface.edit_measure,
% interface.remove_measure

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function PopulateMeasuresListbox(ui,sim)

set( ui.handles.measures_listbox, 'String', sim.measures(:,1), 'Value', 1 );

end   % PopulateMeasuresListbox
