%FILE_MENU calls the functions linked to specific file menu options.
%
% Syntax
% ------
%  ui.file_menu( type );
%
% Details
% -------
% 'type' is defined by what the user clicked. For the file menu, 'type' can
% be 'new', 'open', 'save', 'saveas', or 'exit'.
% 
% Examples
% --------
%  
% See also: interface.options_menu, interface.help_menu, interface.save,
% interface.open, interface.new

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 
function file_menu(varargin)

menuItem = varargin{4};
ui = varargin{1};
sim = ui.CallSimulationAndGraphObjects();
switch lower(menuItem)
    case 'new'
        clear('sim');
        ui.new();
    case 'open'
        ui.open();
    case 'save'
        ui.save(sim);
    case 'saveas'
        ui.save(sim,false); % prompt for new save location
    case 'exit'
        ui.exit();
    otherwise
        ui.error( 'IRM:NotAMenuOption', 'Must select a valid menu option.' );
end % switch

end     % file_menu

