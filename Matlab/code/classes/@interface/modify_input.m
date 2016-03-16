%MODIFY_INPUT modifies the baseline input parameters according to
% user-specifications.
%
% Syntax
% ------
%  ui.modify_input();
%
% Details
% -------
%  This function obtains the modification to be made from the currently
%  entered value in the modify input box.
% 
% Examples
% --------
%  
% See also: interface.UpdateModifyInput, interface.update_axes

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function modify_input(varargin)

ui = varargin{1};
[sim,gr] = ui.CallSimulationAndGraphObjects();
f = strcmpi( sim.Input(:,1), ui.currentlyActiveInput );
if any(f)
    input = get( ui.handles.modifyInput_editbox, 'String' );
    input = eval(input);
    
    numSims = max(cellfun('length',input));
    
    if numSims>21
        ui.error('IRM:TooManySteps','The interface restricts you to 21 steps (-1:.1:1)');
        return; %#ok<UNRCH>
    end
    
   if sum(sim.inputsVaried(:,2)) > 0
    if numSims>11
        dlgbox = questdlg( sprintf('WARNING: You are about to create %d new simulations for each step of the previously varied parameter, each with %d data points. Large simulations like this require a large amount of system memory and can require a long time to run. In extreme cases, this may even crash the simulator. Proceed?.', numSims, sim.npoints));
        if ~strcmpi(dlgbox,'yes'); %if anything other than yes
            return
        end %end
    end
   end
    
    if max(abs(input{1})) > 1
        ui.error('IRM:rhoOutOfRange','rho must be between -1 and 1');
        return; %#ok<UNRCH>
    end
    if ~((10 <= min(input{2})) || (max(input{2}) <= 150))
        ui.error('IRM:NOutOfRange','N must be an integer between 10 and 150');
        return; %#ok<UNRCH>
    end
    sim.modify_input( {sim.Input{f,1},input{:}} ); %#ok<CCAT> % modify_input handles a bunch of stuff.
    
    
    ui.message_center('g','Simulating with modifed input...');
    sim.get_samples();
    
    ui.update_axes(sim,gr)
    
    % And update the plot types list to be the default plot
    % type for that data set.
    defaultPlotType = gr.modifyInput_axes.compatible_plots(sim);
    set( ui.handles.plotTypes_dropdown, 'Value', find(defaultPlotType,1) );
end % any(f)

end          % modify_input
