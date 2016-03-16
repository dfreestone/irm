%REMOVE_MEASURE deletes the currently selected user-defined measure from
% the interface and simulation.
%
% Syntax
% ------
%  ui.remove_measure();
%
% Details
% -------
% Removes the selected measure and then repopulates the measures listbox in
% the interface.
% 
% Examples
% --------
%  
% See also: interface.edit_measure, interface.PopulateMeasuresListbox

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function remove_measure(varargin)

ui = varargin{1};

sim = ui.CallSimulationAndGraphObjects();

if isempty( sim.measures )
    ui.error( 'IRM:RemoveMeasure', 'No measures to remove' );
    return;  %#ok<UNRCH>
end

measureIdx = get( ui.handles.measures_listbox, 'Value' );
if measureIdx > 1
    set( ui.handles.measures_listbox, 'Value', measureIdx-1 );
end

sim.measures(measureIdx,:) = [];
ui.PopulateMeasuresListbox(sim);
ui.message_center('g','Measure removed.');
ui.WriteLog('IRM:RemoveMeasure','Measure removed.');


end        % remove_measure
