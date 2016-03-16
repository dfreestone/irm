%CALLSIMULATIONANDGRAPHOBJECTS calls the simulation and graphics objects
% into the workspace.
%
% Syntax
% ------
%  [sim,gr] = ui.CallSimulationAndGraphObjects();
%
% Details
% -------
% Returns the current simulation and graphics objects, entering them into
% the workspace.
% 
% Examples
% --------
%  

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:30:00 $   

function [sim,gr] = CallSimulationAndGraphObjects(ui)

try
    sim = evalin('base','sim');
    gr  = evalin('base','gr' );
catch me %#ok<NASGU>
    ui.message_center('r','No simulation exists!');
    sim = [];
    gr = [];
end

end  % CallSimulationAndGraphObjects
