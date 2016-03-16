%GETHANDLES obtains and labels handles for text and axes objects.
%
% Syntax
% ------
%  ui.GetHandles();
%
% Details
% -------
% 
% 
% Examples
% --------
%  
% See also: interface.SetCallbacks, interface.CreateUIGraphics

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function GetHandles(ui)

h = guihandles(ui.uihandle);

% preallocate for speed!
input_txt(6,6)=0;
input_axes(6,6)=0;
fields = cell([15,2]);
ind = 0;
for i = 1 : 6
    for j = i+1 : 6
        txt = sprintf( 'txt_%d%d', i,j );
        ax  = sprintf( 'ax_%d%d' , i,j );
        input_txt(i,j)  = h.(txt);
        input_axes(i,j) = h.(ax);
        ind = ind+1;
        fields(ind,:) = {txt,ax};
    end % j
end % i
h = rmfield( h, fields(:) );
ui.handles = h;
ui.handles.input_txt  = input_txt;
ui.handles.input_axes = input_axes;

end % GetHandles
