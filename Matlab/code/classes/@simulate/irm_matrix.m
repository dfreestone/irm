%IRM_MATRIX returns the full 6x6 IRM matrix
%
% Syntax
% ------
%   mat = sim.irm_matrix();
%
% Details
% -------
%
% Examples
% --------
%
%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 2:02:00 $

function m = irm_matrix(~)

% store the full matrix, we're likely to use it a few times.
m = { ...
    'r(s,s)',  'r(s,d)',  'r(s,i)',  'r(s,o)',  'r(s,<i>)'  ,  'r(s,<o>)'
    '-'     ,  'r(d,d)',  'r(i,d)',  'r(o,d)',  'r(d,<i>)'  ,  'r(d,<o>)'
    '-'     ,  '-'     ,  'r(i,i)',  'r(i,o)',  'r(i,<i>)'  ,  'r(i,<o>)'
    '-'     ,  '-'     ,  '-'     ,  'r(o,o)',  'r(o,<i>)'  ,  'r(o,<o>)'
    '-'     ,  '-'     ,  '-'     ,  '-'     ,  'r(<i>,<i>)',  'r(<i>,<o>)'
    '-'     ,  '-'     ,  '-'     ,  '-'     ,  '-'         ,  'r(<o>,<o>)'
    };

end % m = irm_matrix()
