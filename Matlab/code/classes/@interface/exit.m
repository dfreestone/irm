%EXIT closes the interface window.
%
% Syntax
% ------
%  ui.exit();
%
% Details
% -------
% This functions asks the user if they would like to save the current
% simulation before closing the interface window.
% 
% Examples
% --------
%  
% See also: interface.save, interface.CloseFigure

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function exit(varargin)

ui = varargin{1};

prompt      = 'Would you like to save this simulation?';
promptTitle = 'Save Simulation';
choices     = {'Yes', 'No', 'Cancel'};
default     = 'Cancel';

answer = questdlg( prompt, promptTitle, choices{:}, default );
switch lower( answer )
    case 'yes'   , saveState = 1;
    case 'no'    , saveState = 0;
    case 'cancel', saveState = -1;
end %switch

if saveState == -1
    return;
end

if saveState % save then close
    sim = CallSimulationAndGraphObjects(ui);
    ui.save(sim);
    delete( ui.handles.userInterface_figure );
else
    delete( ui.handles.userInterface_figure );
end % saveState


end % exit
