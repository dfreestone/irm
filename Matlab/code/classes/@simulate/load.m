%SAVE loads a simulation
%
% Syntax
% ------
%   sim.load()
%
% Details
% -------
% The user will be prompted for a simulation file to load.
%
%
% Examples
% --------
% See also: simulate.save

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 2:02:00 $

function load( sim )

if isempty( sim.saveName ) || isempty(sim.savePath)
    [sim.saveName,sim.savePath] = uigetfile('*.mat','Open',sim.saveName);
end

fullname = fullfile( sim.savePath, sim.saveName );

if exist( fullname, 'file' )
    load( fullname, 'simfile' );
    
    class = metaclass(sim);
    classProps = class.Properties;
    nProps = length( classProps );
    isConstant = zeros(nProps,1);
    
    for i = 1 : nProps
         isConstant(i) = any(classProps{i}.Constant);
    end
    
    props = properties(sim);
    n = length(props);
    for i = 1 : n
        f = strcmpi( props{i}, simfile(:,1) );  %#ok<NODEF>
        if any(f) && isConstant(i) == 0
            sim.(props{i}) = simfile{f,2};
        end % any
    end % i loop
end

end                      % load
