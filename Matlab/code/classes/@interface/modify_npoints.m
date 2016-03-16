%MODIFY_NPOINTS launches a dialogue box that allows the user to modify the 
% number of samples drawn for each simulation.
%
% Syntax
% ------
%  ui.edit_measures( type );
%
% Details
% -------
% Retrieves and stores number of samples in numeric format in the 
% simulation property sim.npoints.
% 
% Examples
% --------
%  
% See also: interface.options_menu, interface.modify_notes

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function modify_npoints( ui, sim )

def = {num2str(sim.npoints)};

boxname = 'Number of samples';

box = figure('Units', 'normalized', 'Position',[.25,.25,0.25,0.15], 'Menubar', 'none', 'Toolbar', 'none', 'Name', boxname, 'NumberTitle', 'off');
uicontrol(box, 'Style','text','Units', 'normalized','Position',[.07, .66, .85, .15], 'String', 'Number of samples:', 'FontSize', 14, 'HorizontalAlignment', 'Left', 'BackgroundColor', [.8 .8 .8]);
editNPoints = uicontrol(box, 'Style','edit','Units', 'normalized','Position',[.07, .45, .85, .2], 'String', def, 'HorizontalAlignment', 'Left','FontSize', 14);
uicontrol(box, 'Style', 'pushbutton','Units', 'normalized', 'Position',[.78,.03,.2,.2], 'String', 'OK', 'Callback', {@NPointsOKButton, ui, sim, editNPoints, box}  );
uicontrol(box, 'Style', 'pushbutton','Units', 'normalized', 'Position',[.55,.03,.2,.2], 'String', 'Cancel', 'Callback', {@NPointsCancelButton, box} );

end %modify_npoints

function NPointsOKButton(varargin)
ui = varargin{3};
sim = varargin{4};
editNPoints = varargin{5};
box = varargin{6};
npoints = str2double(get( editNPoints, 'String' ));
npoints = round(npoints);

if isnan(npoints)
    ui.error( 'IRM:npointsNotNumeric', 'Must enter valid number' );
    return; %#ok<UNRCH>
end
if npoints<1 || npoints > sim.MAXPOINTS
    ui.error( 'IRM:npointsOutOfRange', sprintf('Number of samples must be between 0 and %d.',sim.MAXPOINTS) );
    return; %#ok<UNRCH>
end

if npoints>20000
    dlgbox = questdlg( 'Simulating a large number of points ( > 20000) can be resource demanding and in extreme cases may crash the simulator. Proceed?');
if ~strcmpi(dlgbox,'yes'); %if anything other than yes
    return
end %end
end

sim.npoints = npoints;
ui.message_center( 'g', sprintf( 'Number of points set to %d', npoints) ); 
ui.WriteLog( 'IRM:SetNPoints', sprintf( 'Number of points set to %d', npoints) ); 
close(box)
end % OKButton

function NPointsCancelButton(varargin)
box = varargin{3};
close(box);
end % NotesCancelButton
