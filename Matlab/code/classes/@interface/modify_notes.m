%MODIFY_NOTES launches a dialogue box that allows the user to enter notes
% on the current simulation.
%
% Syntax
% ------
%  ui.modify_notes( sim );
%
% Details
% -------
% Retrieves and stores notes in string format in the simulation property
% sim.notes.
% 
% Examples
% --------
%  
% See also: interface.options_menu, interface.modify_npoints

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function modify_notes( ui, sim )

        def = sim.notes;
        
        boxname = 'Simulation notes';
        
        box = figure('Units', 'normalized', 'Position',[.25,.25,0.5,0.5], 'Menubar', 'none', 'Toolbar', 'none', 'Name', boxname, 'NumberTitle', 'off');
        uicontrol(box, 'Style','text','Units', 'normalized','Position',[-.11, .91, .6, .04], 'String', 'Notes on simulation:', 'FontSize', 14, 'BackgroundColor', [.8 .8 .8]);
        notes = uicontrol(box, 'Style','edit','Units', 'normalized','Position',[.1, .1, .8, .8], 'String', def, 'HorizontalAlignment', 'Left', 'Max', 2, 'FontSize', 14);
        uicontrol(box, 'Style', 'pushbutton','Units', 'normalized', 'Position',[.92,.01,.07,.07], 'String', 'OK', 'Callback', {@NotesOKButton, ui, sim, box, notes} );
        uicontrol(box, 'Style', 'pushbutton','Units', 'normalized', 'Position',[.835,.01,.07,.07], 'String', 'Cancel', 'Callback', {@NotesCancelButton, box} );
        
end % ModifyNotes
        
    function NotesOKButton(varargin)
        ui = varargin{3};
        sim = varargin{4};
        box = varargin{5};
        notes = varargin{6};
        sim.notes = get(notes, 'String');
        close(box);
        ui.message_center( 'g', 'Notes saved.' );
        ui.WriteLog('IRM:Notes','Notes changed.');
    end % OKButton

    function NotesCancelButton(varargin)
        box = varargin{3};
        close(box);
    end % NotesCancelButton