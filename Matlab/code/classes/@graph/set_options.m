%SET_OPTIONS modifies the properties of the current plot according to 
%the user's specifications.
%
% Syntax
% ------
%   gr.set_options( { object, { property, value } } );
%
% Details
% -------
% You can enter a nx2 cell of the target object (column 1) and the target
% property (column 2).
%
% Examples
% --------
%  

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 2:02:00 $


function set_options( gr, options )
            n = size( options,1 );
            if n == 0 % empty
                return;
            end
            for i = 1 : n
                name  = options{i,1};
                value = options{i,2};
                switch lower(name)
                    case 'figure'
                        set( gr.Figure, value{:} );
                    case 'axes'
                        set( gr.Axes, value{:} );
                    case 'xlabel'
                        set( get(gr.Axes,'XLabel'), value{:} );
                    case 'ylabel'
                        set( get(gr.Axes,'YLabel'), value{:} );
                    case 'zlabel'
                        set( get(gr.Axes,'ZLabel'), value{:} );
                    case 'scatter'
                        set( gr.hScatter, value{:} );
                    case 'line'
                        set( gr.hLine, value{:} );
                    case 'fill'
                        set( gr.hFill, value{:} );
                    case 'image'
                        set( gr.hImage, value{:} );
                    case 'text'
                        gr.hText = text( value{:} );
                    case 'legend'
                        gr.hLegend = legend( value{:} );
                        legend boxoff
                    otherwise
                        error( 'IRM:NotAValidObject', '''Options'' must contain a valid object to modify.' );
                end
                
            end % i
        end    % set_options
