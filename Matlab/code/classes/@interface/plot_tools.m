%PLOT_TOOLS launches a dialogue box that allows the user to modify plot
% properties using the interface.
%
% Syntax
% ------
%  ui.plot_tools( );
%
% Details
% -------
% You must have an open plot to launch the plot tools window.
% 
% Examples
% --------
%  
% See also: interface.plot_selected, interface.plot_all,
% interface.CloseFigure

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function plot_tools(ui,varargin)

plots = ui.graphs;
n = length(plots);
if n==0
    ui.error('IRM:PlotToolsNoUserPlots','You have not created any plots yet. Click Plot Selected.');
    return; %#ok<UNRCH>
end


names = cell([1,n]);
for fig = 1 : n
    names{fig} = get(plots(fig).Figure,'Name');
end
h = LoadPlotToolsBox(plots,ui);
set( h.figlist, 'String', names );
end % plot_tools

function h = LoadPlotToolsBox(plots,ui)

% Set up figure at center of screen
figwidth  = 0.4;
figheight = 0.5;
fig_pos = [0.5-figwidth/2, 0.5-figheight/2, figwidth, figheight];
figProps = ...
    {
    'Name'; 'Plot tools'
    'Parent'; 0
    'Units'; 'normalized'
    'Position'; fig_pos
    'Menubar'; 'none'
    'Toolbar'; 'none'
    'NumberTitle'; 'off'
    };
h.fig = figure(figProps{:});


% Set up Figs box and accompanying text
figlist_pos = [0.1, 0.35,0.35,0.5];
figtext_pos = [0.1, 0.85, 0.35, 0.05];
figlistProps = ...
    {'Parent'; h.fig
    'Units'; 'normalized'
    'Style'; 'listbox'
    'Position'; figlist_pos
    'FontSize'; 14
    };
figtextProps = ...
    {
    'Parent'; h.fig
    'Units'; 'normalized'
    'Style'; 'text'
    'Position'; figtext_pos
    'String'; 'Figures:'
    'FontSize'; 14
    'HorizontalAlignment'; 'left'
    };

% Set up Properties box and accompanying text
optslist_pos = [0.5, 0.35, 0.35, 0.5];
optstext_pos = [0.5, 0.85, 0.35, 0.05];
optslistProps = ...
    {'Parent'; h.fig
    'Units'; 'normalized'
    'Style'; 'listbox'
    'Position'; optslist_pos
    'FontSize'; 14
    };
optstextProps = ...
    {
    'Parent'; h.fig
    'Units'; 'normalized'
    'Style'; 'text'
    'Position'; optstext_pos
    'String'; 'Options:'
    'FontSize'; 14
    'HorizontalAlignment'; 'left'
    };

% Set up edit box
edit_pos = [0.1, 0.20, 0.75, 0.1];
editboxProps = ...
    {
    'Parent'; h.fig
    'Units'; 'normalized'
    'Style'; 'edit'
    'Position'; edit_pos
    'FontSize'; 16
    'String'; '{ ''Property'', ''Value''}'
    };

% Apply box
apply_pos = [0.70, 0.05, 0.15, 0.08];
applyProps = ...
    {
    'Parent'; h.fig
    'Units'; 'normalized'
    'Style'; 'pushbutton'
    'Position'; apply_pos
    'String'; 'Apply'
    'FontSize'; 14
    'Callback'; @apply
    };

% OK box
ok_pos = [0.52, 0.05, 0.15, 0.08];
okProps = ...
    {
    'Parent'; h.fig
    'Units'; 'normalized'
    'Style'; 'pushbutton'
    'Position'; ok_pos
    'String'; 'Ok'
    'FontSize'; 14
    'Callback'; @ok
    };

% close box
close_pos = [0.1, 0.05, 0.15, 0.08];
closeProps = ...
    {
    'Parent'; h.fig
    'Units'; 'normalized'
    'Style'; 'pushbutton'
    'Position'; close_pos
    'String'; 'Close'
    'FontSize'; 14
    'Callback'; @close
    };


% Show all boxes
h.figlist = uicontrol(figlistProps{:});
uicontrol( figtextProps{:} );
h.optslist = uicontrol(optslistProps{:});
uicontrol( optstextProps{:} );
h.editbox = uicontrol(editboxProps{:});
h.applybox = uicontrol(applyProps{:});
h.okbox = uicontrol(okProps{:});
h.closebox = uicontrol(closeProps{:});

% Now that we got all the handles, set figlist callback
set( h.figlist, 'Callback', {@figList_click,h,plots} );
set( h.applybox, 'Callback', {@apply,h,plots} );
set( h.okbox, 'Callback', {@ok,h,plots,ui} );
set( h.closebox, 'Callback', {@closebox,h} );


end
function figList_click(~,~,h,plots)
idx = get( h.figlist, 'Value' );
opts = {'Figure','Axes','hFill','hScatter','hLine','hImage','hText','hLegend', 'xlabel', 'ylabel', 'zlabel'};
n = length(opts);
tagForDelete = false([1,n]);
for i = 1 : n
    if any(strcmpi(opts{i}, {'xlabel', 'ylabel', 'zlabel'}))
        continue;
    end
    if isempty(plots(idx).(opts{i}))
        tagForDelete(i) = true;
        if strcmpi( opts{i}, 'hImage' )
            tagForDelete(strcmpi(opts, 'zlabel' )) = true;
        end
    end
end % i
opts(tagForDelete) = [];

% make it flash so the user knows something changed.
set( h.optslist, 'String', '' );
pause(0.05);
set( h.optslist, 'String', strrep(opts,'h','') );


end % figList_click

function apply(~, ~, h, plots)

figIdx  = get( h.figlist, 'Value' );
optIdx  = get( h.optslist, 'Value' );
optName = get( h.optslist, 'String' );
opts    = get( h.editbox, 'String' );

% TEST THIS STUFF LIKE CRAZY!!!
% logic is to remove all property/value pairs that are either
% labeled "property" or labeled "value" but don't have "string" in
% front.
f = find(strcmpi( opts, 'property' ));
if ~isempty(f)
    f = [f, f+1];
    opts(f)=[];
end
f = find(strcmpi( opts, 'value' ));
if ~isempty(f)
    g = find( strcmpi(opts(f-1),'string'));
    f=[f,f-1];
    f(f==g)=[];
    opts(f)=[];
end

if isempty(optName) %If haven't clicked on a property yet
    return
end %end

options = [lower(optName{optIdx}), {eval(opts)}];
plots(figIdx).set_options( options );
end
function ok(~, ~, h, plots,ui) 
apply([],[],h,plots);
close(h.fig);
ui.message_center('g','Applied Figure changes.');
ui.WriteLog('IRM:PlottoolsSuccess', 'Applied Figure changes.');
end
function closebox(~,~,h)
close(h.fig);
end
