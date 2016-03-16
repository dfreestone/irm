%OPTIONS_MENU calls the functions linked to specific options menu items.
%
% Syntax
% ------
%  ui.options_menu( type );
%
% Details
% -------
% 'type' is defined by what the user clicked. In the options menu, this
% can be 'addnotes', 'npoints', 'usecdfs', or 'interpolate'.
% 
% Examples
% --------
%  
% See also: interface.file_menu, interface.help_menu,
% interface.modify_npoints, interface.modify_notes
% 

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function options_menu(varargin)

menuItem = varargin{4};
ui = varargin{1};
[sim,gr] = ui.CallSimulationAndGraphObjects();
switch lower(menuItem)
    case 'addnotes'
        ui.modify_notes( sim );
        
    case 'npoints'
        ui.modify_npoints( sim );
        
    case 'usecdfs'
        %make use_cdf the opposite of whatever it currently is.
        if sim.use_cdf
            sim.use_cdf = 0; %don't use cdfs
            set(ui.handles.useCdfs_menu, 'Checked', 'off')%checkmark off
            ui.message_center( 'g', 'No longer using stored distributions.' )
        else
            sim.use_cdf = 1; %use cdfs
            set(ui.handles.useCdfs_menu, 'Checked', 'on') %checkmark on
            ui.message_center( 'g', 'Now using stored distributions.' )
        end
        
    case 'interpolate'
        % change interpolate to its opposite.
        if gr.input_axes(1,1).interpolate
            [gr.input_axes(:).interpolate, gr.modifyInput_axes.interpolate] ...
                = deal(false);
            set(ui.handles.interpolate_menu, 'Checked', 'off') %checkmark off
            ui.message_center( 'g', 'No longer interpolating 3-d plots.' )
        else
            [gr.input_axes(:).interpolate, gr.modifyInput_axes.interpolate] ...
                = deal(true);
            set(ui.handles.interpolate_menu, 'Checked', 'on') %checkmark on
            ui.message_center( 'g', 'Now interpolating 3-d plots.' )
        end % if interpolate
        
    otherwise
        ui.error( 'IRM:NotAMenuOption', 'Must select an available menu option.' );
end % switch



end  % options_menu
