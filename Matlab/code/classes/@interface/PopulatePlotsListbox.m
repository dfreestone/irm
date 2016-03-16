%POPULATEPLOTSLISTBOX adds a new measure and plot type combination to the 
% current simulation to the list of available measure and plot type 
% combinations.
%
% Syntax
% ------
%  ui.PopulatePlotsListbox();
%
% Details
% -------
% Responsible specifically for populating the plots listbox.
% 
% Examples
% --------
%  
% See also: interface.populate_lists, interface.PopulateMeasuresListbox,
% interface.PopulatePlottypesDropdown

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function PopulatePlotsListbox(ui)

n = size( ui.plots, 1 );
plot_list = cell( [n,1] );
for i = 1 : n
    if ui.plots{i,4}
        sampleIdxStr = 'selected samples';
    else
        sampleIdxStr = 'all samples';
    end
    plot_list{i} = sprintf( '%s: %s (%s)', ui.plots{i,2}, ui.plots{i,1}, sampleIdxStr );
end % i

set( ui.handles.plots_listbox, 'String', plot_list, 'Value', 1 );

end          % PopulatePlottypesDropdown
