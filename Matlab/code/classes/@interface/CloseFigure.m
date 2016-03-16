%CLOSEFIGURE deletes a figure permanently when a user closes it.
%
% Syntax
% ------
%  ui.closefigure(figure_handle);
%
% Details
% -------
% This function deletes a figure handle from the graphics objects whenever
% the user closes it.
% 
% Examples
% --------
%  
% See also: interface.exit, graph

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:40:00 $ 

function CloseFigure(varargin)

ui = varargin{1};
hFig = varargin{2};

name = get( hFig, 'Name' );

n = length(ui.graphs);
names = cell([1,n]);
for i = 1 : n
    names{i} = get( ui.graphs(i).Figure, 'name' );
end % i


d = strcmpi( names, name );
ui.graphs(d).delete();
ui.graphs(d) = [];

delete(hFig);
end % 