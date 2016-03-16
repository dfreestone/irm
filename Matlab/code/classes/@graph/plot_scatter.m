%PLOT_SCATTER plots a scatterplot of a series of x and y value pairs.
%
% Syntax
% ------
%   gr.plot_scatter ( x, y );
%   gr.plot_scatter ( x, y, options );
%
% Details
% -------
% gr.plot_scatter ( x, y );
%   creates a scatterplot with default settings. x and y must be vectors 
%   of equal length.
% 
% gr.plot_scatter ( x, y, options );
%   If you choose to modify properties of the default graph, you can enter 
%   a nx2 cell of the target object (column 1) and the target property
%   (column 2) as options.
%
% Examples
% --------
%  
% See also: graph.plot, graph.plot_histogram, graph.plot_line, 
% graph.plot_heat, graph.plot_contour, graph.plot_surface

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 2:02:00 $   



function plot_scatter( gr, x, y, varargin )
            
            options = [];
            if ~isempty( varargin ),options = varargin{1}; end
            
            %--------------------------------------------------------------
            % step 1: obtain our measures
            
            b = regstats( y, x, 'linear', 'beta' );
            
            xfit = [min(x), max(x)];
            yfit = b.beta(1) + b.beta(2)*xfit;
            
            if numel(x) > 1e4 % limit to drawing 10,000 points.
                x = x(1:1e3);
                y = y(1:1e3);
            end
            
            %--------------------------------------------------------------
            % step 2: Initial plotting
            if isempty( gr.Figure ), gr.Figure = figure; end
            if isempty( gr.Axes ), gr.Axes = axes; end
            
            cla( gr.Axes );
            hold( gr.Axes, 'all' );
            
            % set figure and axes properties first, since some properties
            % (like coloroder) should be set before plotting.
            if ~isempty(options)
                f = strcmpi( 'figure', options(:,1) );
                a = strcmpi( 'axes'  , options(:,1) );
                in = f | a;
                gr.set_options( options(in,:) );
            end % nargin
            
            gr.hScatter = plot( gr.Axes, x, y, '.' );
            gr.hLine = plot( gr.Axes, xfit, yfit );
            
            %--------------------------------------------------------------
            % step 3: initializing options
            
            
            % set default options
            DefaultOptions = ...
                {
                'axes'   , {'FontSize', 0.85*gr.FontSize, 'Box', 'on'}
                'xlabel' , {'FontSize', gr.FontSize, 'FontName', gr.FontName, 'String', 'x'}
                'ylabel' , {'FontSize', gr.FontSize, 'FontName', gr.FontName, 'String', 'y'}
                'line'   , {'LineWidth', 3, 'Color', 'k', 'LineSmooth', 'on'}
                'scatter', {'Color', 0.5*ones(1,3)}
                };
            gr.set_options( DefaultOptions );
            
            % now set axes stuff, including any user figure/axes properties we
            % may have just written over with the default.
            if ~isempty(options)
                gr.set_options( options );
            end % nargin
            
        end    % plot_scatter
