%GET_VARIED returns the varied parameter name/value pair.
%
% Syntax
% ------
%   varied = sim.get_varied();
%   [varied, isN] = get_varied();
%
% Details
% -------
% varied = sim.get_varied()
%    The output is a nx2 cell matrix (n<=2) where column 1 is the varied name
%    and column 2 are the varied values.
% [varied, isN] = get_varied()
%    Returns an nx1 boolean vector corrosponding to varied that indicates
%    whether the N parameter was varied.
%
% Examples
% --------
%  
% See also: simulate.modify_input

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 2:02:00 $

function [varied, isN] = get_varied(sim)

varied = [];

[r,c] = find(sim.inputsVaried);

n = length(r);
if n>0
    varied = cell([n,2]);
    for i = 1 : n
        varied(i,:) = sim.Input(r(i),[1,c(i)]);
    end
end % n>0

isN = c==3;

end % get_varied