%PLOT Determines the appropriate plot type based on the current
%simulation and prepares and sends in the data to the appropriate plot type.
%
% Syntax
% ------
%   gr.plot( sim, measure_name );
%   gr.plot( sim, measure_name, plot_type );
%   gr.plot( sim, measure_name, options );
%   gr.plot( sim, measure_name, plot_type, options );
%
% Details
% -------
% gr.plot( sim, measure_name );
%   Determines the appropriate plot type based on the current simulation.
%   Organizes the samples in a structure that the appropriate plot type can
%   display. measure_name is specified in string format.
%
% gr.plot( sim, measure_name, plot_type );
%   Plots the specified measure according the user-specified plot type.
%   plot_type is specified in string format.
%
% gr.plot( sim, measure_name, options );
%   Determines the appropriate plot type based on the current simulation.
%   If you choose to modify properties of the default plot, you can enter a
%   nx2 cell of the target object (column 1) and the target property
%   (column 2) as options.
%
% gr.plot( sim, measure_name, plot_type, options );
%   Plots the specified measure according the user-specified plot type.
%   If you choose to modify properties of the default plot, you can enter a
%   nx2 cell of the target object (column 1) and the target property
%   (column 2) as options.
%
% Examples
% --------
%
% See also: graph.plot_scatter, graph.plot_histogram, graph.plot_line, graph.plot_heat,
% graph.plot_contour, graph.plot_surface

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 2:02:00 $

function plot( gr, sim, measure, varargin )

isacell = cellfun( @iscell, varargin );
isastr  = cellfun( @ischar, varargin );

options = [];
plottype = '';
if any(isacell) , options = varargin{isacell}; end
if any(isastr)  , plottype = varargin{isastr}; end

compatible = gr.compatible_plots(sim);
if isempty(plottype)
    plottype = gr.PlotTypes{find(compatible,1), 1};
end

isPerfectPlot = any(strcmpi(gr.PlotTypes(compatible,1), plottype));
if isPerfectPlot
    [nr,nc] = size(sim.randomsamples);
    gr.sample = {1:nr, 1:nc};
else
    n_support = gr.PlotTypes{find(compatible,1),2};
    n_request = gr.PlotTypes{strcmpi(plottype,gr.PlotTypes(:,1)),2};
    if (n_support-n_request)>0
        gr.DataSelector(sim, measure, n_request);
        if ~isempty(options) % ugh...if they downsamples, the options are wrong.
            if n_request == 0 % easy case, downsampled to histogram
                rx = strcmpi(options(:,1), 'xlabel');
                cx = strcmpi(options{rx,2},'String');
                options{rx,2}{find(cx)+1} = measure;
                ry = strcmpi(options(:,1), 'ylabel'); % ylabel
                cy = strcmpi(options{ry,2},'String');
                options{ry,2}{find(cy)+1} = 'Probability';
            elseif n_request == 1
                % we know the zlabel downs to ylabel as measure
                rx = strcmpi(options(:,1), 'ylabel');
                cx = strcmpi(options{rx,2},'String');
                options{rx,2}{find(cx)+1} = measure;
                % xlabel is whatever direction they dragged...
                varied = sim.get_varied();
                varied = varied(:,1);
                if length(gr.sample{1}) < length(gr.sample{2}) % they dragged across cols
                    xlbl = varied{1};
                else
                    xlbl = varied{2};
                end
                rx = strcmpi(options(:,1), 'xlabel');
                cx = strcmpi(options{rx,2},'String');
                options{rx,2}{find(cx)+1} = xlbl;
            else
                error( 'IRM:CannotPlotSamples', 'Select another plot type to use' )
            end
        end
    else
        error('IRM:GraphNotSupported', 'Your data does not support a %s plot',plottype)
    end
end

rows = gr.sample{1};
cols = gr.sample{2};

switch lower(plottype)
    case 'scatter'
        xy = cell2mat( sim.compute( measure, rows, cols ) );
        x = xy(:,1);
        y = xy(:,2);
        gr.plot_scatter( x,y, options );
        
    case 'histogram' % histogram default
        if sim.correlation_inputchk(measure) %can't plot hist of corrs between derived measures
            error( 'IRM:CannotPlotHistOfCorrs', 'Cannot plot a histogram of correlations between derived measures.' )
            return %#ok<UNRCH>
        end %if
        func = sprintf( 'hist( %s, -1:.01:1 )', measure );
        x = -1 : 0.01: 1;
        y = cell2mat( sim.compute( func, rows, cols ) );
        y = bsxfun( @rdivide, y, sum(y) );
        xtheory = [];
        ytheory = [];
        m = sim.irm_matrix();
        f = find( strcmpi(m(1,:), measure) );
        if any(f)
            xtheory = -1:0.01:1;
            ytheory = 0.01 * rpdf( xtheory, sim.Input{f,2:3} );
        end % any(f)
        gr.plot_histogram( x,y, xtheory, ytheory, options );
        
        
    case 'line' % line default
        if ~sim.correlation_inputchk(measure)
            mu_func = sprintf( 'mean(%s)', measure );
            sd_func = sprintf( 'std(%s)', measure );
            y = cell2mat( sim.compute(mu_func, rows, cols) );
            e = cell2mat( sim.compute(sd_func, rows, cols) );
        else
            y = cell2mat( sim.compute(measure, rows, cols) );
            e = [];
        end
        varied = sim.get_varied();
        if length(cols) > length(rows)
            x = varied{1,2}(cols);
        else
            x = varied{2,2}(rows);
        end
        gr.plot_line( x,y,e, options );
        
        
    case {'heat','heatmap'} % heat default
        if ~sim.correlation_inputchk(measure)
            mu_func = sprintf( 'mean(%s)', measure );
        else
            mu_func = measure;
        end
        f = find( sim.inputsVaried );
        x = sim.Input{f(1)};
        y = sim.Input{f(2)};
        z = cell2mat( sim.compute(mu_func, rows, cols) );
        gr.plot_heat( x,y,z,options );
        
    case 'contour'
        if ~sim.correlation_inputchk(measure)
            mu_func = sprintf( 'mean(%s)', measure );
        else
            mu_func = measure;
        end
        f = find( sim.inputsVaried );
        x = sim.Input{f(1)};
        y = sim.Input{f(2)};
        z = cell2mat( sim.compute(mu_func, rows, cols) );
        gr.plot_contour( x,y,z,options );
        
    case 'surface'
        if ~sim.correlation_inputchk(measure)
            mu_func = sprintf( 'mean(%s)', measure );
        else
            mu_func = measure;
        end
        f = find( sim.inputsVaried );
        x = sim.Input{f(1)};
        y = sim.Input{f(2)};
        z = cell2mat( sim.compute(mu_func, rows, cols) );
        gr.plot_surface( x,y,z,options );
        
    otherwise
        error( 'IRM:NotAValidPlotType', 'Must select a valid plot type' );
end % switch
end % plot