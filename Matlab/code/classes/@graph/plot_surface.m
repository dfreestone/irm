%PLOT_SURFACE generates a surface plot displaying the mean values of 
%measure z at varying levels inputs x and y.
%
% Syntax
% ------
%  gr.plot_surface( x, y, z );
%  gr.plot_surface( x, y, z, options );
%
% Details
% -------
% gr.plot_surface( x, y, z );
%   Creates a scatterplot with default settings. Varied measures 
%   x and y must be in vector form. Target measure z must be a nxm
%   matrix of derived values. You can rotate this plot in 3-d 
%   space by toggling the 'rotate 3D' option in Matlab's plot toolbar. 
%   Once this option is toggled, click and drag the surface to manipulate
%   its display.
% 
% gr.plot_surface( x, y, z, options );
%   If you choose to modify properties of the default graph, you can enter 
%   a nx2 cell of the target object (column 1) and the target property
%   (column 2) as options.
%
% Examples
% --------
%  
% See also: graph.plot, graph.plot_scatter, graph.plot_histogram, 
% graph.plot_line, graph.plot_heat, graph.plot_contour

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 17:13:00 $   

function plot_surface( gr, x,y,z, varargin )
            
            options = [];
            if ~isempty( varargin ),options = varargin{1}; end
            
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
            end % nargin
            
            gr.hImage = surf( x, y, z, 'EdgeColor', 'none' );
            colormap( 'Jet' );
            shading interp
            
            %--------------------------------------------------------------
            % step 3: initializing options
            
            
            DefaultOptions = ...
                {
                'axes'   , {'FontSize', 0.85*gr.FontSize, 'XLim', [min(x),max(x)], 'YLim', [min(y),max(y)]}
                'xlabel' , {'FontSize', gr.FontSize, 'FontName', gr.FontName, 'String', 'x'}
                'ylabel' , {'FontSize', gr.FontSize, 'FontName', gr.FontName, 'String', 'y'}
                'zlabel' , {'FontSize', gr.FontSize, 'FontName', gr.FontName, 'String', 'z'}
                };
            
            
            gr.set_options( DefaultOptions );
            
            % now set axes stuff, including any user figure/axes properties we
            % may have just written over with the default.
            if ~isempty(options)
                gr.set_options( options );
            end % nargin
        end    % plot_surface
