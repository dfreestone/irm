%POPULATEPLOTTYPESDROPDOWN enters all available plot types into the
% dropdown plot types menu in the interface.
%
% Syntax
% ------
%  ui.PopulatePlottypesDropdown(gr);
%
% Details
% -------
% Responsible specifically for populating the dropdown listbox of
% available plot types.
% 
% Examples
% --------
%  
% See also: interface.populate_lists, interface.PopulateMeasuresListbox,
% interface.PopulatePlotsListbox

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function PopulatePlottypesDropdown(ui,gr)

plottypes = gr.PlotTypes(:,1);
isScatter = strcmpi(plottypes,'scatter');
plottypes{isScatter} = 'Scatter [x, y]';
set( ui.handles.plotTypes_dropdown, 'String', plottypes, 'Value', 1, 'FontSize', 14 );

end  % PopulatePlottypesDropdown
