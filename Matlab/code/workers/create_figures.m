function create_figures(fig)

switch fig 
    case 1
        sim = simulate();
        
        %% Panel a
        
        x = 0 : .1 : 1;
        input = {
            'r(s,d)', x            , 26
            'r(s,i)', [0.2 0.5 0.8], 26};
        sim.modify_input( input );
        sim.npoints = 1e7;
        
        sim.get_samples();
        
        y = cell2mat( sim.compute( 'mean(Self-Enhancement)' ) )';
        
        gr = graph();
        
        colororder = repmat( [0.2 0.5 0.8]', [1,3] );
        options = ...
            {
            'figure', {'Name', 'Figure 1a'}
            'axes'  , {'YLim', [0.0, 0.8], 'ColorOrder', colororder, 'XGrid', 'off',...
            'YGrid', 'off', 'Xlim', [0 1], 'XTick', (0:.2:1) }
            'line'  , {'LineWidth', 4 }
            'xlabel', {'FontSize', 22, 'FontName', 'Arial', 'String', 'Self-Positivity, r_{S,D}'}
            'ylabel', {'FontSize', 22, 'FontName', 'Arial', 'String', 'Self-Enhancement'}
            'legend', {'r_{S,I} = 0.20','r_{S,I} = 0.50','r_{S,I} = 0.80','Location','NorthWest'}
            };
        
        gr.plot_line( x, y, options );
        
        %% Panel b
        input = {
            'r(s,d)', [0.2 0.5 0.8], 26
            'r(s,i)', 0 : .1 : 1   , 26};
        sim.modify_input( input );
        sim.npoints = 9e6;
        
        sim.get_samples();
        
        x = (0 : .1 : 1);
        y = cell2mat( sim.compute( 'mean(Self-Enhancement)' ) )';
        
        gr = graph();
        
        colororder = repmat( [0.2 0.5 0.8]', [1,3] );
        options = ...
            {
            'figure', {'Name', 'Figure 1a'}
            'axes'  , {'YLim', [0.0, 0.8], 'ColorOrder', colororder, 'XGrid', 'off',...
            'YGrid', 'off', 'Xlim', [0 1], 'XTick', (0:.2:1) }
            'line'  , {'LineWidth', 4 }
            'xlabel', {'FontSize', 22, 'FontName', 'Arial', 'String', 'Projection to Ingroup, r_{S,I}'}
            'ylabel', {'FontSize', 22, 'FontName', 'Arial', 'String', 'Self-Enhancement'}
            'legend', {'r_{S,I} = 0.20','r_{S,I} = 0.50','r_{S,I} = 0.80','Location','NorthEast'}
            };
        
        gr.plot_line( x, y, options );
        
    case 2
        sim = simulate();
        sim.npoints = 9e6;
        sim.get_samples();
        
        bins = '-1:.01:1';
        measures = '[r(s,o), r(s,i)]';
        
        func = sprintf( 'hist( %s, %s )', measures, bins );
        
        x = eval(bins);
        y = cell2mat( sim.compute( func ) );
        y = bsxfun( @rdivide, y, sum(y) );
        
        %
        
        colororder = repmat( [0.2 0.5 0.8]', [1,3] );
        options = ...
            {
            'figure', {'Name', 'Figure 2a', }
            'axes'  , {'ColorOrder', colororder, 'XTick', (-1:.5:1), 'XGrid', 'on', 'YGrid', 'off',...
            'XLim', [-1 1], 'YLim', [0 .035], 'YTick', linspace(0,.035,4), 'YTickLabel', [], 'XTickLabel', [] }
            'line'  , {'LineWidth', 5, 'LineSmoothing', 'on' }
            'xlabel', {'FontSize', 22, 'FontName', 'Arial', 'String', []}
            'ylabel', {'FontSize', 22, 'FontName', 'Arial', 'String', 'Probability'}
            'legend', {'Projection to Outgroup', 'Projection to Ingroup', 'Location', 'NorthWest'}
            };
        
        gr = graph();
        gr.plot_line( x, y, options );
        set(gca, 'FontSize', 14)
        
        %% Panel b
        
        measures = '[r(o,d), r(i,o), r(i,d)]';
        
        func = sprintf( 'hist( %s, %s )', measures, bins );
        
        x = eval(bins);
        y = cell2mat( sim.compute( func ) );
        y = bsxfun( @rdivide, y, sum(y) );
        
        %
        colororder = repmat( [0.2 0.5 0.8]', [1,3] );
        
        options = ...
            {
            'figure', {'Name', 'Figure 2a', }
            'axes'  , {'ColorOrder', colororder, 'XTick', (-1:.5:1), 'XGrid', 'on', 'YGrid', 'off',...
            'XLim', [-1 1], 'YLim', [0 .065], 'YTick', linspace(0,.065,4), 'YTickLabel', [], 'XTickLabel', [] }
            'line'  , {'LineWidth', 5, 'LineSmoothing', 'on' }
            'xlabel', {'FontSize', 22, 'FontName', 'Arial', 'String', []}
            'ylabel', {'FontSize', 22, 'FontName', 'Arial', 'String', 'Probability'}
            'legend', {'Outgroup Positivity, Intergroup Accentuation', 'Ingroup Positivity', 'Location', 'NorthWest'}
            };
        
        gr = graph();
        gr.plot_line( x, y, options );
        set(gca, 'FontSize', 14);
        
        %%
        measures = '[Ingroup Favoritism, Self-Enhancement, Differential Accuracy]';
        
        func = sprintf( 'hist( %s, %s )', measures, bins );
        
        x = eval(bins);
        y = cell2mat( sim.compute( func ) );
        y = bsxfun( @rdivide, y, sum(y) );
        
        %
        colororder = repmat( [0.2 0.5 0.8]', [1,3] );
        
        options = ...
            {
            'figure', {'Name', 'Figure 2a', }
            'axes'  , {'ColorOrder', colororder, 'XTick', (-1:.5:1), 'XGrid', 'on', 'YGrid', 'off',...
            'XLim', [-1 1], 'YLim', [0 .04], 'YTick', linspace(0,.04,4), 'YTickLabel', [] }
            'line'  , {'LineWidth', 3, 'LineSmoothing', 'on' }
            'xlabel', {'FontSize', 22, 'FontName', 'Arial', 'String', 'Correlation Coefficient'}
            'ylabel', {'FontSize', 22, 'FontName', 'Arial', 'String', 'Probability'}
            'legend', {'Ingroup Favoritism', 'Self-Enhancement','Differential Accuracy', 'Location', 'NorthWest'}
            };
        
        gr = graph();
        gr.plot_line( x, y, options );
        set(gca, 'FontSize', 14);
        
    case 3
        sim = simulate();
        %% Panel a
        
        sim.npoints = 5e5;
        x = linspace( 0, .999, 20 );
        sim.modify_input( {'r(s,d)', x, 26} );
        
        measure = 'corrcoef([r(i,o), Self-Enhancement, Ingroup Favoritism, Differential Accuracy])';
        
        sim.get_samples();
        %
        y = cell2mat(sim.compute( measure ));
        
        % Don't plot the zero mean ones...
        mu = nanmean( y );
        f  = abs(mu) < 0.005; % reasonable threshold.
        y(:,f) = nan;
        
        colororder = repmat( linspace(0,.5,2)', [1,3] );
        linestyleorder = {'-', ':', '--' };
        options = ...
            {
            'figure', {'Name', 'Figure 3a', 'Color', 'white'}
            'axes'  , {'ColorOrder', colororder, 'LineStyleOrder', linestyleorder, 'XGrid', 'on', 'YGrid', 'off', 'XTick',0:.25:1, 'Xlim', [0 1], 'YTick', -0.75:.25:0.75, 'YLim', [-0.76, 0.76]}
            'line'  , {'LineWidth', 5 }
            'xlabel', {'FontSize', 22, 'FontName', 'Arial', 'String', 'Self-Positivity, r_{S,D}'}
            'ylabel', {'FontSize', 22, 'FontName', 'Arial', 'String', 'Correlation Coefficient'}
            'legend', {'r_{IA,SE}*', 'r_{IA,IF}', 'r_{IA,DA}*', 'r_{SE,IF}', 'r_{SE,DA}', 'r_{IF,DA}', 'Location', 'NorthEastOutside'}
            };
        
        gr = graph();
        gr.plot_line( x, y, options );
        
        legend('boxon');
        
        %% Panel b
        
        sim.modify_input( {'r(s,i)', x, 26; 'r(s,d)', 0.5, 26} );
        
        measure = 'corrcoef([r(i,o), Self-Enhancement, Ingroup Favoritism, Differential Accuracy])';
        
        sim.get_samples();
        %
        y = cell2mat(sim.compute( measure ));
        
        % Don't plot the zero mean ones...
        mu = nanmean( y );
        f  = abs(mu) < 0.001; % reasonable threshold.
        y(:,f) = nan;
        
        colororder = repmat( linspace(0,.5,2)', [1,3] );
        linestyleorder = {'-', ':', '--' };
        options = ...
            {
            'figure', {'Name', 'Figure 3b','Color', 'white'}
            'axes'  , {'ColorOrder', colororder, 'LineStyleOrder', linestyleorder, 'XGrid', 'on', 'YGrid', 'off', 'XTick',0:.25:1,'Xlim', [0 1], 'YTick', -0.75:.25:0.75, 'YLim', [-0.76, 0.76] }
            'line'  , {'LineWidth', 5 }
            'xlabel', {'FontSize', 22, 'FontName', 'Arial', 'String', 'Projection to Ingroup, r_{S,I}'}
            'ylabel', {'FontSize', 22, 'FontName', 'Arial', 'String', 'Correlation Coefficient'}
            'legend', {'r_{IA,IF}', 'r_{SE,IF}', 'r_{SE,DA}', 'r_{IF,DA}', 'Location', 'NorthEastOutside'}
            };
        
        gr = graph();
        gr.plot_line( x, y, options );
        
        legend('boxon');
        set(legend, 'visible', 'off')
        
        %% Panel c
        
        x = linspace( -0.5, 0.5, 20 );
        sim.modify_input( {'r(s,o)', x, 26;'r(s,i)', 0.5, 26; 'r(s,d)', 0.5, 26} );
        
        measure = 'corrcoef([r(i,o), Self-Enhancement, Ingroup Favoritism, Differential Accuracy])';
        
        sim.get_samples();
        %
        y = cell2mat(sim.compute( measure ));
        
        colororder = repmat( linspace(0,.5,2)', [1,3] );
        linestyleorder = {'-', ':', '--' };
        options = ...
            {
            'figure', {'Name', 'Figure 3c','Color', 'white'}
            'axes'  , {'ColorOrder', colororder, 'LineStyleOrder', linestyleorder, 'XGrid', 'on', 'YGrid', 'off', 'XTick',-0.5:.25:0.5, 'Xlim', [-0.5 0.5], 'YTick', -0.75:.25:0.75, 'YLim', [-0.76, 0.76] }
            'line'  , {'LineWidth', 5 }
            'xlabel', {'FontSize', 22, 'FontName', 'Arial', 'String', 'Projection to Outgroup, r_{S,O}'}
            'ylabel', {'FontSize', 22, 'FontName', 'Arial', 'String', 'Correlation Coefficient'}
            'legend', {'r_{IA,SE}*', 'r_{IA,IF}', 'r_{IA,DA}*', 'r_{SE,IF}', 'r_{SE,DA}', 'r_{IF,DA}', 'Location', 'NorthEastOutside'}
            };
        
        gr = graph();
        gr.plot_line( x, y, options );
        
        legend('boxon');
        set(legend, 'visible', 'off')
    case 4
        %% Panel a
        
        sim = simulate();
        
        sim.npoints = 1e5;
        x = linspace( 0, 1, 30 );
        y = linspace( 0, 1, 30 );
        sim.modify_input( {'r(s,d)', y, 26; 'r(s,i)', x, 26} );
        
        measure = 'corrcoef([Self-Enhancement, Ingroup Favoritism, Differential Accuracy])';
        
        sim.get_samples();
        
        z = (sim.compute( measure ));
        Za = z{1}(1);
        
        
        options = ...
            {
            'Figure' , {'Name', 'Figure 1a'}
            'Axes'   , {'Box', 'on', 'XTick', linspace(0,.99,5), 'XTickLabel', [0 .25 .50 .75 1], 'YTick', linspace(0,.99,5), 'YTickLabel', [0 .25 .50 .75 1]}
            'image'  , {'LabelSpacing',1000, 'LevelList', [-0.6, -.4, -.2, 0, .2, .4, .6, .8], 'LineWidth', 4, 'LineColor', zeros(1,3)}
            'xlabel' , {'String', 'Projection to Ingroup, r_{S,I}'}
            'ylabel' , {'String', 'Self-Positivity, r_{S,D}'}
            'line'   , {'LineSmoothing','on'}
            };
        
        gr = graph();
        gr.plot_contour( x, y, Za{1}', options );
        %% Panel b
        
        Zb = z{1}(3);
        
        options = ...
            {
            'Figure' , {'Name', 'Figure 2b'}
            'Axes'   , {'Box', 'on', 'XTick', linspace(0,.99,5), 'XTickLabel', [0 .25 .50 .75 1], 'YTick', linspace(0,.99,5), 'YTickLabel', [0 .25 .50 .75 1]}
            'image'  , {'LabelSpacing', 1e3, 'LevelList', [ 0.025; 0.1; 0.2; 0.3; 0.4; 0.5; 0.60], 'LineWidth', 4, 'LineColor', zeros(1,3)}
            'xlabel' , {'String', 'Projection to Ingroup, r_{S,I}'}
            'ylabel' , {'String', 'Self-Positivity, r_{S,D}'}
            };
        
        gr = graph();
        gr.plot_contour( x, y, Zb{1}', options );
        
        %% Panel c
        
        x = linspace( 0, 1, 30 );
        y = linspace( -0.5, 0.5, 30 );
        
        sim.modify_input( {'r(s,d)', 0.5, 26; 'r(s,i)', x, 26; 'r(s,o)', y, 26} );
        
        measure = 'corrcoef([Self-Enhancement, Ingroup Favoritism, Differential Accuracy])';
        
        sim.get_samples();
        
        z = (sim.compute( measure ));
        Zc = z{1}(3);
        
        options = ...
            {
            'Figure' , {'Name', 'Figure 2c'}
            'Axes'   , {'Box', 'on', 'XTick', linspace(0,1,5), 'XTickLabel', [0 .25 .50 .75 1], 'YTick', linspace(-.5,.5,5), 'YTickLabel', linspace(-.5,.5,5)}
            'image'  , {'LabelSpacing', 1e3, 'LevelList', [0.1:0.1:0.5, 0.55], 'LineWidth', 4, 'LineColor', zeros(1,3)}
            'xlabel' , {'String', 'Projection to Ingroup, r_{S,I}'}
            'ylabel' , {'String', 'Projection to Outgroup, r_{S,O}'}
            };
        
        gr = graph();
        gr.plot_contour( x, y, Zc{1}, options );
    otherwise
        error;
end




end % create_figures