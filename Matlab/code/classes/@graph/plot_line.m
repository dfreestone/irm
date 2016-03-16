%PLOT_LINE plots a line of mean values of measure y and (optionally)
%their standard deviations.
%
% Syntax
% ------
%  gr.plot_line( x, means );
%  gr.plot_line( x, means, std_dev );
%  gr.plot_line( x, means, options );
%  gr.plot_line( x, means, std_dev, options );
%
% Details
% -------
% gr.plot_line( x, means );
%   Creates a line plot with default settings. X and means must be vectors of equal length.
%
% gr.plot_line( x, means, std_dev );
%   Creates a line plot with default settings and standard deviation.
%   std_dev is an optional input; it will plot the standard deviation
%   of each mean as light shading.
%
% gr.plot_line( x, means, options );
%   If you choose to modify properties of the default graph, you can enter
%   a nx2 cell of the target object (column 1) and the target property
%   (column 2) as options.
%
% gr.plot_line( x, means, std_dev, options );
%   Creates a line plot with standard deviation and user-specified
%   properties. If you choose to modify properties of the default graph,
%   you can enter a nx2 cell of the target object (column 1) and the
%   target property (column 2) as options.
%
%
% Examples
% --------
%
% See also: graph.plot, graph.plot_scatter, graph.plot_histogram,
% graph.plot_heat, graph.plot_contour, graph.plot_surface

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 17:00:00 $


function plot_line( gr, x, y, varargin )
%--------------------------------------------------------------
% step 1: obtain our measures

options=[];
isacell = cellfun( @iscell,varargin);
if any(isacell)
    options = varargin{isacell};
end

% transpose vars if needed
if diff(size(x))<0, x=x'; end
if diff(size(y))<0, y=y'; end

xbounds = [];
ybounds = [];
isnum = cellfun(@isnumeric,varargin);
if any(isnum)
    e = varargin{isnum};
    if ~isempty(e)
        if diff(size(e))<0, e=e'; end
        xbounds = [x,fliplr(x)];
        ybounds = [y+e, fliplr(y-e)];
    end
end

%--------------------------------------------------------------
% step 2: Initial plotting
if isempty( gr.Figure ), gr.Figure = figure; end
if isempty( gr.Axes ), gr.Axes = axes; end


cla( gr.Axes );
hold( gr.Axes, 'all' );

c = colormap( 'Winter' );
colorOrder = round(linspace( 1, size(c,1), min(size(y)) ));
colorOrder = c(colorOrder,:);
set( gr.Axes, 'ColorOrder', colorOrder );

% set figure and axes properties first, since some properties
% (like coloroder) should be set before plotting.
if ~isempty(options)
    f = strcmpi( 'figure', options(:,1) );
    a = strcmpi( 'axes'  , options(:,1) );
    in = f | a;
    gr.set_options( options(in,:) );
end % nargin


gr.hFill = fill( xbounds, ybounds, 'r', 'Parent', gr.Axes );
gr.hLine = plot( gr.Axes, x, y );

%--------------------------------------------------------------
% step 3: initializing options

if any(size(y)==1)
    % put them first so user defined ones can overwrite them.
    options = ...
        [{'line', {'Color', gr.FireBrickRed};
        'fill', {'FaceColor', lighten_color(gr.FireBrickRed, 0.3)}
        }; options];
end

DefaultOptions = ...
    {
    'axes'   , {'FontSize', 0.85*gr.FontSize, 'Xgrid', 'on', 'Ygrid', 'on', 'Box', 'on', 'YLim', [-1, 1], 'XLim', gr.get_limits(x,0.2), 'XTick', [-1, 0, 1]}
    'xlabel' , {'FontSize', gr.FontSize, 'FontName', gr.FontName, 'String', 'x'}
    'ylabel' , {'FontSize', gr.FontSize, 'FontName', gr.FontName, 'String', 'y'}
    'line'   , {'LineWidth', 3, 'LineSmoothing','on'}
    'fill'   , {'EdgeColor', 'none' }
    };


gr.set_options( DefaultOptions );

% now set axes stuff, including any user figure/axes properties we
% may have just written over with the default.
if ~isempty(options)
    gr.set_options( options );
end % nargin
end       % plot_line
