%PLOT_SELECTED creates a new figure to display the currently selected
% measure and plot type combination.
%
% Syntax
% ------
%  ui.plot_selected();
%
% Details
% -------
%  Gets the value of the currently selected measure and plot type 
%  combination, creates new figure and axes objects, and draws the 
%  specified plot.
% 
% Examples
% --------
%  
% See also: interface.plot_all, interface.remove_plot, interface.plot_tools

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function plot_selected(ui,~,~)

if isempty(ui.plots)
    ui.error('IRM:NoPlots','You have not created any plots.');
    return; %#ok<UNRCH>
end

sim = ui.CallSimulationAndGraphObjects();

selected = get( ui.handles.plots_listbox, 'Value' );
measure  = ui.plots{selected,1};
plottype = ui.plots{selected,2};

gr = graph(); % must initialize as graph object.

% get number of graphics (if first time, overwrite existing graph, bc its a
% placeholder to avoid double -> graph conversions).
n = length(ui.graphs);
n = n + 1;

[x_label, y_label, z_label] = gr.get_labels( sim, measure );
options = gr.options_from_labels(x_label, y_label, z_label);
options = [options; {'Figure', {'Name', sprintf('Figure: %d', n)}}];
gr.plot( sim, measure, plottype, options );

%add M and SD text to histogram
if strcmpi(plottype, 'Histogram')
    sampleLocation = cell2mat(gr.sample);
    
    targetSamples = sim.compute(measure);
    
    measureMean = mean(cell2mat(targetSamples(sampleLocation(1),sampleLocation(2))));
    measureMean = sprintf('%.2f',measureMean);
    
    measureSD = std(cell2mat(targetSamples(sampleLocation(1),sampleLocation(2))));
    measureSD = sprintf('%.2f',measureSD);
    
    textMean = sprintf( 'Mean = %s', measureMean);
    textSD = sprintf( 'SD = %s', measureSD);
    
    textDisplay = {textMean, textSD};
    text(0.77, 0.92, textDisplay, 'Units', 'normalized', 'FontSize', 12);
end


% When the user closes the box, we want to delete it from the graphs list
set( gr.Figure, 'CloseRequestFcn', @ui.CloseFigure, 'NumberTitle', 'off' );

if isempty(ui.graphs)
    ui.graphs = gr;
else
    ui.graphs(n) = gr;
end

ui.message_center('g',sprintf('%s (%s) created', measure, plottype));
ui.WriteLog('IRM:PlotCreated', sprintf('%s (%s) created', measure, plottype));

end         % plot_selected
