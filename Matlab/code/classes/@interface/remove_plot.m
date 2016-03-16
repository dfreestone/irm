%REMOVE_PLOT removes a current measure and plot type combination from 
% the interface window.
%
% Syntax
% ------
%  ui.remove_plot();
%
% Details
% -------
% Removes the selected measure and plot type combination and then 
% repopulates the measures listbox in the interface.
% 
% 
% Examples
% --------
%  
% See also: interface.populate_lists, interface.add_plot

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function remove_plot(varargin)

ui = varargin{1};
plotListIdx = get( ui.handles.plots_listbox, 'Value' );

if isempty( ui.plots )
    ui.error( 'IRM:RemovePlot', 'No plots to remove' );
    return; %#ok<UNRCH>
end

if plotListIdx > 1
    set( ui.handles.plots_listbox, 'Value', plotListIdx-1 );
end

ui.plots(plotListIdx,:) = [];
ui.PopulatePlotsListbox();
ui.message_center('g','Plot removed.');
ui.WriteLog('IRM:RemovePlot','Plot removed.');

end           % remove_plot
