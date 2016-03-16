%ADD_PLOT adds a measure and plot type to the list of measures to be
% plotted.
%
% Syntax
% ------
%  ui.add_plot();
%
% Details
% -------
% This function combines the currently selected measure and plot type into
% a single measure/plot combination, adding it to the list of measures to
% plot.
% 
% Examples
% --------
%  
% See also: interface.remove_plot, interface.PopulatePlotsListbox

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:25:00 $   

function add_plot(varargin)

ui = varargin{1};

[sim, gr] = ui.CallSimulationAndGraphObjects();

if isempty(sim.measures)
    ui.error( 'IRM:NoMeasuresToPlot', 'No measures to plot. Add some.' );
    return; %#ok<UNRCH>
end

measureIdx = get( ui.handles.measures_listbox, 'Value' );
measures   = get( ui.handles.measures_listbox, 'String' );
measure    = measures{ measureIdx };

plottypeIdx = get( ui.handles.plotTypes_dropdown, 'Value' );
plottypes   = gr.modifyInput_axes.PlotTypes;
plottype    = plottypes{plottypeIdx,1};

[nr,nc] = size(sim.randomsamples); 
ui.plots(end+1,:) = {measure, plottype, 1:nr, 1:nc };

set( ui.handles.plots_listbox, 'Value', size(ui.plots,1) );
ui.PopulatePlotsListbox();

ui.message_center('g', 'Plot added.');
ui.WriteLog('IRM:PlotAdded','Plot added.');

end              % add_plot
