%POPULATE_LISTS calls the functions responsible for populating various list
% boxes in the interface.
%
% Syntax
% ------
%  ui.populate_lists( sim, gr );
%
% Details
% -------
% Enters available plot types, user-defined measures, and measure and plot
% type combinations into their respective list boxes in the interface
% window.
% 
% Examples
% --------
%  
% See also: interface.PopulateMeasuresListbox,
% interface.PopulatePlotsListbox, interface.PopulatePlottypesDropdown

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function populate_lists( ui, sim, gr )

ui.message_center( 'g', 'Populating lists...' );
ui.PopulatePlottypesDropdown(gr.modifyInput_axes); % needs the 'plotTypes' field
ui.PopulateMeasuresListbox(sim);                   % needs the 'measures' field
ui.PopulatePlotsListbox();                         % not sure what this needs yet.
ui.message_center( 'g', 'Populating lists...done' )

end         % populate_lists
