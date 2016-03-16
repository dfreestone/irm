%UPDATE_AXES redraws the smaller axes to reflect the current simulation.
%
% Syntax
% ------
%  ui.update_axes( sim, gr );
%
% Details
% -------
% Loops through all small axes in the interface window, redrawing each to
% reflect the current simulation.
% 
% Examples
% --------
%  
% See also: interface.UpdateModifyInput, interface.modify_input

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function update_axes(ui,sim,gr)

ui.message_center( 'g', 'Updating axes...' );
% now go through each input axes and
m = sim.irm_matrix();
inputOptions = ...
    {
    'axes', {'YTick',[], 'FontSize', 0.5*gr.input_axes(1,2).FontSize}
    'xlabel', {'String',''}
    'ylabel', {'String',''}
    };
for i = 1 : 6
    for j = i+1 : 6
        if i~=j+1
            options = [inputOptions; {'axes',{'XTick',[]}}];
        else
            options = inputOptions;
        end
        gr.input_axes(i,j).plot( sim, m{i,j},options );
        children = get( gr.input_axes(i,j).Axes,'Children');
        set( children, 'ButtonDownFcn', @ui.click );
    end % j
end % i
ui.UpdateModifyInput(sim,gr)
ui.message_center( 'g', 'Updating axes...done' );

end                % update_axes
