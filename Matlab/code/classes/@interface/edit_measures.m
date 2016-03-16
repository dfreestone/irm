%EDIT_MEASURES adds new and edits current user-defined measures to the
% interface.
%
% Syntax
% ------
%  ui.edit_measures( ~, ~, type );
%
% Details
% -------
% 'type' is defined by what the user clicked. 'add' adds a new measure 
% to the list, while 'edit' allows the user to edit a current measure.
% 
% Examples
% --------
%  
% See also: interface.PopulateMeasuresListbox, interface.remove_measure

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/10/06 19:48:00 $ 

function edit_measures(ui,~,~,type)

sim = ui.CallSimulationAndGraphObjects;

derivedMeasures = sim.measures; %store a working copy of sim.measures
inputMeasures = {'r(s,d)';'r(s,i)';'r(s,o)';'r(s,<i>)';'r(s,<o>)';...
                          'r(i,d)';'r(o,d)';'r(d,<i>)';'r(d,<o>)';...
                                   'r(i,o)';'r(i,<i>)';'r(i,<o>)';...
                                            'r(o,<i>)';'r(o,<o>)';...
                                                    'r(<i>,<o>)'};
inputMeasures = repmat(inputMeasures,2);                                                                       
allMeasures = cat(1,derivedMeasures,inputMeasures);

h = LoadMeasuresBox(ui, sim, allMeasures, type);

switch lower(type) %switch
    case 'add' %add new measure

        set(h.edit_name, 'String', 'New Measure');
        set(h.edit_expr, 'String', 'New Formula');
        set(h.fig, 'Name', 'Add New Measure');

    case 'edit' %edit currently selected measure
        n = get( ui.handles.measures_listbox, 'Value' );
        
        set(h.edit_name, 'String', derivedMeasures{n,1});
        set(h.edit_expr, 'String', derivedMeasures{n,2});
        set(h.fig, 'Name', sprintf('%s: %s', 'edit', derivedMeasures{n,1}));

end %switch

end % MeasuresBox

function h = LoadMeasuresBox(ui, sim, allMeasures, type)

% Set up figure at center of screen
figwidth  = 0.4;
figheight = 0.6;
h.fig = figure(...
    'Name', 'Define Measure', ...
    'Parent', 0, ...
    'Units', 'normalized', ...
    'Position', [0.5-figwidth/2, 0.5-figheight/2, figwidth, figheight], ...
    'Menubar', 'none', ...
    'Toolbar', 'none', ...
    'NumberTitle', 'off');

% Buttons
h.buttongroup = uibuttongroup( ...
    'Parent', h.fig, ...
    'Units', 'normalized', ...
    'Position', [0.1, 0.45,0.35,0.5], ...
    'FontSize', 14, ...
    'Title', 'Transformations');

% Each of the n radio buttons:
radios = {'None','Mean','Median','Mode','Square Root','Variance','Standard Deviation','Correlation','Covariance'};
n = length(radios);
for i = 1 : n
    pos = [0.05, 0.985 - (i/10), 0.8, 0.06];
    h.radio(i) = uicontrol( ...
        'Parent', h.buttongroup, ...
        'Style', 'radiobutton', ...
        'String', radios{i}, ...
        'Units','normalized', ...
        'Position', pos, ...
        'HandleVisibility','off', ...
        'FontSize', 14);
end

% The measures box

h.options_panel = uipanel(...
    'Parent', h.fig, ...
    'Units', 'normalized', ...
    'Title', 'Existing Measures', ...
    'Position', [0.5, 0.45, 0.35, 0.5], ...
    'FontSize', 14);

h.instructions_panel1 = uicontrol(...
    'Parent', h.fig, ...
    'Units', 'normalized', ...
    'Style', 'text', ...
    'String', 'Highlight one or more measures. Keyboard shortcuts can cut (ctrl+x) copy (ctrl+c) and paste (ctrl+v). Mouse dragging and ctrl + click can select multiple items.', ...
    'Position', [0.852, 0.63, 0.155, 0.3], ...
    'FontSize', 11);

h.instructions_panel2 = uicontrol(...
    'Parent', h.fig, ...
    'Units', 'normalized', ...
    'Style', 'text', ...
    'String', 'Enter #n (where n is the nth item you clicked) to insert the measure into that location. For example, clicking apply will replace #2 with the second measure you clicked.', ...
    'Position', [0.854, 0.125, 0.15, 0.32], ...
    'FontSize', 11);

measuresList = allMeasures(:,1);
h.options_list = uicontrol( ...
    'Parent', h.fig, ...
    'Units', 'normalized', ...
    'Style', 'listbox', ...
    'Max', 2, ...
    'Position', [0.51, 0.46, 0.335, 0.44], ...
    'FontSize', 14, ...
    'String', measuresList);

% Set up name edit box
h.edit_name = uicontrol(...
    'Parent', h.fig, ...
    'Units', 'normalized', ...
    'Style', 'edit', ...
    'Position', [0.1, 0.30, 0.75, 0.1], ...
    'FontSize', 16, ...
    'String', 'Name');

h.edit_expr = uicontrol(...
    'Parent', h.fig, ...
    'Units', 'normalized', ...
    'Style', 'edit', ...
    'Position', [0.1, 0.18, 0.75, 0.1], ...
    'FontSize', 16, ...
    'String', 'Expression');

% The apply, ok, and cancel buttons
% Apply box
h.apply = uicontrol(...
    'Parent', h.fig, ...
    'Units', 'normalized', ...
    'Style', 'pushbutton', ...
    'Position', [0.70, 0.05, 0.15, 0.08], ...
    'String', 'Apply', ...
    'FontSize', 14);

% OK box
h.accept = uicontrol(...
    'Parent', h.fig, ...
    'Units', 'normalized', ...
    'Style', 'pushbutton', ...
    'Position', [0.52, 0.05, 0.15, 0.08], ...
    'String', 'Accept', ...
    'FontSize', 14);

% cancel box
h.cancel = uicontrol(...
    'Parent', h.fig, ...
    'Units', 'normalized', ...
    'Style', 'pushbutton', ...
    'Position', [0.1, 0.05, 0.15, 0.08], ...
    'String', 'Cancel', ...
    'FontSize', 14);

%set callbacks after uicontrols are created
set(h.options_list, 'Callback', {@updateFields, h, allMeasures});
set(h.apply,        'Callback', {@apply, h});
set(h.accept,       'Callback', {@accept, h, ui, sim, type});
set(h.cancel,       'Callback', {@cancel, h});
set(h.fig,          'CloseRequestFcn', {@cancel, h});

end % LoadMeasuresBox

function updateFields(~, ~, h, allMeasures)

%check for first click
if isempty(get(h.edit_expr, 'UserData'));
    selected = [];
else
    userData = get(h.edit_expr, 'UserData');
    selected = userData{2,:};
    selected = selected{1};
end %end

%remove/add highlighted values in click order
selectedValues = get(h.options_list, 'Value');

[remove, removeIdx] = setdiff(selected, selectedValues);
selected(removeIdx) = [];

add = setdiff(selectedValues,selected);

if ~isempty(add) %if clicked same measure
selected = [selected add];
end %end

%store measure names and values in userdata
addMeasure = {allMeasures{selected,1}};
newValues = {selected};

set(h.edit_expr, 'UserData', {addMeasure; newValues}); 

end

function apply(~,~,h)

selectedExpr = {get(h.edit_expr, 'String')}; 

if findstr(selectedExpr{1}, '#') %if #
    
clickedMeasures = get(h.edit_expr, 'UserData');

if isempty(clickedMeasures);
    return
end

clickedMeasures = clickedMeasures{:,1};

n = length(clickedMeasures);

for i = 1 : n %i
strChar = ['#' num2str(i)];
selectedExpr = strrep(selectedExpr, strChar, clickedMeasures(i));
end %end i

set(h.edit_expr, 'String', selectedExpr{1})

%replace any leftover #
if findstr(selectedExpr{1}, '#') %if # remains
    
    %get numbers following each #
    selectedExpr = get(h.edit_expr, 'String');
    charLocation = (strfind(selectedExpr, '#'));
    numLocation = (charLocation +1);
    n = length(numLocation);
    
    for i = 1:n %for
    numValues(i) = str2double(selectedExpr(numLocation(i)));
    end %end
    
    %remove repeat numbers
    [numValues,ind] = sort(numValues);
    numValues = unique(numValues);
    
    %
    for i = 1:(length(numValues))
        selectedExpr = strrep(selectedExpr, ['#' num2str(numValues(i))], ['#' num2str(i)]);
    end
    
    set(h.edit_expr, 'String', selectedExpr); 
    
end

set(h.edit_expr, 'UserData', []); %reset list of clicked measures

end

%get desired operation to apply
selectedRadio = get(h.buttongroup, 'SelectedObject');
radioString = get(selectedRadio, 'String');
radioString = lower(radioString);

%add appropriate operator to current formula
if strcmpi(radioString, 'None');
    return
elseif strcmpi(radioString, 'Standard Deviation')
newExpr = sprintf('%s(%s)','std', selectedExpr{1});
elseif strcmpi(radioString, 'Variance')
newExpr = sprintf('%s(%s)','var', selectedExpr{1});
elseif strcmpi(radioString, 'Square Root')
newExpr = sprintf('%s(%s)','sqrt', selectedExpr{1});
elseif strcmpi(radioString, 'Correlation')
newExpr = sprintf('%s(%s)','corrcoef', selectedExpr{1});
elseif strcmpi(radioString, 'Covariance')
newExpr = sprintf('%s(%s)','cov', selectedExpr{1});
else %any other operator
newExpr = sprintf('%s(%s)',radioString, selectedExpr{1});
end

set(h.edit_expr, 'String', newExpr);
set(h.buttongroup, 'SelectedObject', h.radio(1));

end

function accept(~,~,h,ui,sim,type)

%update sim.measures

if strcmpi(type, 'add')
    n = (length(sim.measures) + 1);
else
    n = get(ui.handles.measures_listbox, 'Value');
end % end

selectedMeasure = get(h.edit_name, 'String');
newExpr = get(h.edit_expr, 'String');

sim.measures(n,:) = {selectedMeasure, newExpr};
set(ui.handles.measures_listbox, 'String', sim.measures(:,1));
ui.message_center('g', 'Measure updated');
ui.WriteLog('IRM:MeasureAddEdit', 'Measure updated');

close(h.fig);

end

function cancel(~,~,h)
delete(h.fig);
end
