%SAVE saves the current simulation
%
% Syntax
% -------
%   sim.save()
%   sim.save(overwrite)
%
% Details
% -------
% The first time sim.save() is called, the user will be prompted for a save
% location. Subsequent calls will save over this file.
%
% If you want to "save as..." (save a file that was already saved), you can
% pass in "true" to the method: sim.save(true);
% 
%  
% See also: simulate.load

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 2:02:00 $
function save( sim, overwrite )

if nargin<2, overwrite = true; end

if isempty(sim.savePath) || ~overwrite
    if isempty(sim.saveName), sim.saveName = 'untitled'; end
    [sim.saveName,sim.savePath] = uiputfile( '*', 'Save as...', sim.saveName );
    
    if isempty(sim.savePath) %User clicks cancel
        return; 
    end
    
end

fullname = fullfile( sim.savePath, sim.saveName );
props = properties(sim);
n = length(props);
simfile = cell( [n,2] );

for i = 1 : n
    simfile(i,:) = {props{i}, sim.(props{i})};
end
save( fullname, 'simfile' );

end              % save
