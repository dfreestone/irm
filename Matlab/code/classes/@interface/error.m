%ERROR documents errors encountered while using the interface.
% 
% Syntax
% ------
%  ui.error( messageId, messageString );
%
% Details
% -------
% This function adds the received error message ID tag and error text to
% ui.WriteLog.
% 
% Examples
% --------
%  
% See also: interface.WriteLog, interface.message_center

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function error(ui, msgId, msgStr )

ui.message_center('r',msgStr);
ui.WriteLog(msgId, msgStr);

end % error
