%WRITELOG stores errors encounted while using the interface.
%
% Syntax
% ------
%  ui.WriteLog(  messageId, messageString );
%
% Details
% -------
% This function adds the received message ID tag and error text to the text
% file that stores all encountered error messages (IRMLog.txt).
% 
% Examples
% --------
%  
% See also: interface.error, interface.message_center

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function WriteLog( ~, msgId, msgStr )

writeTime = datestr(now);
fileID = fopen('IRMLog.txt','a');
fprintf(fileID,'@%s\t%s: %s\n',writeTime,msgId,msgStr);
fclose(fileID);

end % WriteLog