%PLOT_HEAT plots a heatmap of mean values of measure z at each level of
%varied inputs x and y.
%
% Syntax
% ------
%  gr.plot_heat( x, y, z )
%  gr.plot_heat( x, y, z, options )
%
% Details
% -------
% gr.plot_heat( x, y, z )
%   Creates a default heatmap. Varied measures x and y must be in vector 
%   form. Target measure z must be an nxm matrix of derived values.
%   
% gr.plot_heat( x, y, z, options )
%   Creates a heatmap modified according to user-specified properties.
%   If you choose to modify properties of the default graph, 
%   you can enter a nx2 cell of the target object (column 1) and the 
%   target property (column 2) as options.
%
% Examples
% --------
%  
% See also: graph.plot, graph.plot_scatter, graph.plot_histogram, 
% graph.plot_line, graph.plot_contour, graph.plot_surface

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 17:05:00 $   

function plot_heat( gr, x, y, z, varargin )
            
            options = [];
            if ~isempty(varargin), options = varargin{1}; end
            
            %--------------------------------------------------------------
            % step 1: obtain our measures
            
            if gr.interpolate
                [x,y] = meshgrid( x,y );
                x = interp2( x, 4 );
                y = interp2( y, 4 );
                z = interp2( z, 4 );
                
                x = x(1,:);
                y = y(:,1);
            end % gr.interpolate
            
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
            end % ~isempty(options)
            
            
            gr.hImage = imagesc( 'Parent',gr.Axes, 'XData',x,'YData',y,'CData',z);
            
            if gr.isInputGraph
                caxis(gr.Axes, [-1, 1])
            end
            
            colormap( 'Jet' );
            
            DefaultOptions = ...
                {
                'axes'   , {'FontSize', 0.85*gr.FontSize, 'XLim', [min(x),max(x)], 'YLim', [min(y),max(y)]}
                'xlabel' , {'FontSize', gr.FontSize, 'FontName', gr.FontName, 'String', 'x'}
                'ylabel' , {'FontSize', gr.FontSize, 'FontName', gr.FontName, 'String', 'y'}
                };
            
            gr.set_options( DefaultOptions );
            
            % now set axes stuff, including any user figure/axes properties we
            % may have just written over with the default.
            if ~isempty(options)
                gr.set_options( options );
            end % nargin
        end       % plot_heat
