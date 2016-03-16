%CONVERTMEASURE converts a user-defined measure into its base input
%measures.
%
% Syntax (hidden method)
% ------
%   base_measure = sim.ConvertMeasure(measure_name);
%
% Details
% -------
%
% Examples
% --------
%
% See also: simulate.add_measure, simulate.edit_measure, simulate.remove_measure

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 2:02:00 $

function m = ConvertMeasure( sim, measure )
m = measure;

% [1]: first convert all user defined measures into input measures
%      Note that we need a while loop because they can nest
%      defined measures ad infinitum.
measureList = sim.measures;
n = size( measureList,1 );
done = false;
while ~done
    for i = 1 : n
        m = strrep( m, measureList{i,1}, measureList{i,2} );
    end % i
    idx = zeros([n,1]);
    for i = 1 : n
        idx(i) = any(strfind( m, measureList{i,1} ));
    end % i
    if ~any(idx), done = true; end
end % while

% [2]: now convert all input measures into first row input measures.
measureList = sim.irm_matrix();
for i = 2 : 6
    for j = i+1 : 6
        oldStr = measureList{i,j};
        newStr = sprintf( '(%s*%s)', measureList{1,i}, measureList{1,j} );
        m = strrep( m, oldStr, newStr );
    end % i
end % j

% [3]: now convert all first row input measures to indices
for i = 1 : 6
    oldStr = measureList{1,i};
    newStr = sprintf( 'r(%s,%d)', ':',i);
    m = strrep( m, oldStr, newStr );
end % i
m = vectorize(m);
end % func
