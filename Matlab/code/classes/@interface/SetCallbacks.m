%SETCALLBACKS defines callback functions for specific interface objects.
%
% Syntax
% ------
%  ui.SetCallbacks();
%
% Details
% -------
% 
% 
% Examples
% --------
%  
% See also: interface.GetHandles, interface.CreateUIGraphics

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function SetCallbacks(ui)

% Input_axes
for i = 1 : 6
    for j = i+1 : 6
        set( ui.handles.input_axes(i,j), 'ButtonDownFcn', @ui.click );
    end % j
end % i

set( ui.handles.modifyInput_editbox , 'Callback', @ui.modify_input );

set( ui.handles.addMeasure_button   , 'Callback', {@ui.edit_measures, 'add'} );
set( ui.handles.editMeasure_button  , 'Callback', {@ui.edit_measures, 'edit'} );
set( ui.handles.removeMeasure_button, 'Callback', @ui.remove_measure );

set( ui.handles.addPlot_button   , 'Callback', @ui.add_plot );
set( ui.handles.removePlot_button, 'Callback', @ui.remove_plot );

set( ui.handles.plotAll_button     , 'Callback', @ui.plot_all );
set( ui.handles.plotSelected_button, 'Callback', @ui.plot_selected );
set( ui.handles.plotTools_button   , 'Callback', @ui.plot_tools );

% Set close request function on the window to exit
set( ui.uihandle, 'CloseRequestFcn', @ui.exit );

% file menu
set( ui.handles.new_menu         , 'Callback', {@ui.file_menu,'new'} );
set( ui.handles.open_menu        , 'Callback', {@ui.file_menu,'open'} );
set( ui.handles.save_menu        , 'Callback', {@ui.file_menu,'save'} );
set( ui.handles.saveAs_menu      , 'Callback', {@ui.file_menu,'saveAs'} );
set( ui.handles.saveDefaults_menu, 'Callback', {@ui.file_menu,'saveDefaults'} );
set( ui.handles.exit_menu        , 'Callback', {@ui.file_menu,'exit'} );

% options menu
set( ui.handles.addNotes_menu   , 'Callback', {@ui.options_menu,'addNotes'} );
set( ui.handles.nPoints_menu    , 'Callback', {@ui.options_menu,'nPoints'} );
set( ui.handles.useCdfs_menu    , 'Callback', {@ui.options_menu,'useCDFs'} );
set( ui.handles.interpolate_menu, 'Callback', {@ui.options_menu,'interpolate'} );

% help menu
set( ui.handles.about_menu        , 'Callback', {@ui.help_menu,'about'} );
set( ui.handles.manual_menu       , 'Callback', {@ui.help_menu,'manual'} );

%To be released with next version
%set( ui.handles.createFigures_menu, 'Callback', {@ui.help_menu,'createFigures'} )

end % setCallbacks
