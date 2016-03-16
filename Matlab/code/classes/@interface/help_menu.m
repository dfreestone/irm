%HELP_MENU calls the functions linked to specific help menu options.
%
% Syntax
% ------
%  ui.help_menu( type );
%
% Details
% -------
% 'type' is defined by what the user clicked. In the help menu, this can
% either be 'about' or 'manual'.
% 
% Examples
% --------
%  
% See also: interface.options_menu, interface.file_menu

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function help_menu(varargin)

menuItem = varargin{4};
switch lower(menuItem)
    case 'about'
        open( 'about_interface.fig' );
        imshow('Logo.png');
        
    case 'manual'
        open( 'Manual.pdf' );
        
    case 'createfigures';
        h = open( 'create_MS_figures.fig' );
        
        %load figure images into pushbuttons
        children = get(h, 'Children');
        ind = [7 9 6 5]; %pushbuttons
        
        children = children(ind);
        whichFigure = {'Figure1.PNG'; 'Figure2.PNG'; 'Figure3.PNG'; 'Figure4.PNG'};
        
        figure = {};
        
        for i = 1:length(children); %i
           figure{i} = imread(whichFigure{i});
           figure{i} = imresize(figure{i}, [185 215]);
           set(children(i), 'CData', figure{i});
        end %i
   
    otherwise
        ui.error( 'IRM:NotAMenuOption', 'Must select ''about'' or ''manual''' )
end % switch

end     % help_menu
