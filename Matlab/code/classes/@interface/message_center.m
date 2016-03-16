%MESSAGE_CENTER displays instructions, error text, and simulation updates
% at the top of the interface.
%
% Syntax
% ------
%  ui.message_center( color, message );
%
% Details
% -------
%  color must be entered as a Matlab recognized color indicator (example:
%  'r' for 'red'). message must be entered a string to display in the
%  message center of the interface.
% 
% Examples
% --------
%  
% See also: interface.error, interface.WriteLog

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function message_center( ui, color, message )

set( ui.handles.message_center, 'BackgroundColor', color, 'String', message );
drawnow;

end  % message_center
