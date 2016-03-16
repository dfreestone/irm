%PLOT_HISTOGRAM plots a probability histogram or line of measure x.
%
% Syntax
% ------
%  gr.plot_histogram( xfill, yfill )
%  gr.plot_histogram( [], [], xline, yline )
%  gr.plot_histogram( xfill, yfill, xline, yline )
%  gr.plot_histogram( xfill, yfill, xline, yline, options )
%
% Details
% -------
% gr.plot_histogram( xfill, yfill )
%   Creates a filled histogram with default settings. xfill is a vector of
%   bins and yfill is vector of probabilities of observation.
%    
% gr.plot_histogram( [], [], xline, yline )
%   Creates a line histogram with default settings. xfill is a vector of
%   bins and yfill is vector of probabilities of observation.
%
% gr.plot_histogram( xfill, yfill, xline, yline )
%   Creates a default filled histogram with a line tracing the 
%   distribution.
% 
% gr.plot_histogram( xfill, yfill, xline, yline, options )
%   Creates a filled histogram with a line tracing the distribution,
%   modified according to user-specified properties. If you choose to 
%   modify properties of the default graph, you can enter a nx2 cell of the
%   target object (column 1) and the target property (column 2) as options.
%  
% 
% Examples
% --------
%  
% See also: graph.plot, graph.plot_scatter, graph.plot_line, 
% graph.plot_heat, graph.plot_contour, graph.plot_surface

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 16:55:00 $   


function plot_histogram( gr, x,y, xtheory, ytheory, varargin )
            
            options = [];
            if ~isempty( varargin ),options = varargin{1}; end
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
                if any(in)
                    gr.set_options( options(in,:) );
                end % any(in)
            end
            
            if ~isempty(x)
            % transpose if needed
            if diff(size(x))<0, x = x'; end
            if diff(size(y))<0, y = y'; end
            
%           preventive problem: if the histogram doesn't start or end
%           near 0 (y-axis), the fill will look funky.
            x = [x(1), x, x(end)];
            y = [0,y,0];

            end %isempty x
            
            gr.hFill = fill( x, y, 'r', 'Parent', gr.Axes );
            gr.hLine = plot( gr.Axes, xtheory, ytheory );
            
            %--------------------------------------------------------------
            % step 3: initializing options
            
            DefaultOptions = ...
                {
                'axes'  , {'FontSize', 0.85*gr.FontSize, 'Xgrid','on', 'Box', 'on', 'XLim', [-1, 1], 'YLim', [0, 1.3*max([y(:);ytheory(:)])]}
                'xlabel', {'FontSize', gr.FontSize, 'FontName', gr.FontName, 'String', 'x'}
                'ylabel', {'FontSize', gr.FontSize, 'FontName', gr.FontName, 'String', 'Probability'}
                'line'  , {'LineWidth', 5, 'Color', gr.FireBrickRed, 'LineSmooth', 'on'}
                'fill'  , {'FaceColor', gr.DeepSkyBlue, 'EdgeColor', 'none'}
                };
            
            % if the colororder property was set, modify the 'line' options
            if ~isempty(options)
                f = strcmpi( options(:,1), 'axes' );
                if any(f)
                    f = find(strcmpi( DefaultOptions(:,1), 'line' ));
                    m = find(strcmpi( DefaultOptions(f,:), 'Color' ));
                    DefaultOptions{f,2}(m:m+1) = [];
                end
            end
            
            gr.set_options( DefaultOptions );
                        
            % now set axes stuff, including any user figure/axes properties we
            % may have just written over with the default.
            if ~isempty(options)
                gr.set_options( options );
            end % nargin
        end  % plot_histogram
