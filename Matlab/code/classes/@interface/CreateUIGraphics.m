%CREATEUIGRAPHICS initializes the objects in the interface.
%
% Syntax
% ------
%  ui.CreateUIGraphics();
%
% Details
% -------
% This function assigns a new handle to each object in the interface.
% 
% Examples
% --------
%  
% See also: interface.SetCallbacks, interface.GetHandles

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:45:00 $ 

function gr = CreateUIGraphics(ui)

ui.message_center( 'g', 'Creating graphics objects...' );
gr.modifyInput_axes = graph();
gr.modifyInput_axes.Figure = ui.uihandle;
gr.modifyInput_axes.Axes   = ui.handles.modifyInput_axes;
gr.modifyInput_axes.isModifyInputGraph = true;
for i = 1 : 6
    for j = i+1:6
        gr.input_axes(i,j) = graph();
        gr.input_axes(i,j).Figure = ui.uihandle;
        gr.input_axes(i,j).Axes   = ui.handles.input_axes(i,j);
        gr.input_axes(i,j).isInputGraph = true;
    end % j
end % i
ui.message_center( 'g', 'Creating graphics objects...done' );

end           % CreateUIGraphics
