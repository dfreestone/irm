%PLOT_ALL generates a new plot for each measure and plot combination in the
% currently in the plot list window of the interface.
%
% Syntax
% ------
%  ui.plot_all();
%
% Details
% -------
%  Runs ui.plot_selected for every measure and plot type combination
%  in the interface window.
% 
% Examples
% --------
%  
% See also: interface.plot_selected, interface.remove_plot,
% interface.plot_tools

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function plot_all(varargin)

ui = varargin{1};
n = size( ui.plots, 1 );
for i = 1 : n
    set( ui.handles.plots_listbox, 'Value', i );
    ui.plot_selected();
end % i

end              % plot_all
