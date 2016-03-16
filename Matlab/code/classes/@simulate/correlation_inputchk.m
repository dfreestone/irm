%CORRELATION_INPUTCHK checks to see if the requested measure requires
% calculating correlations or covariance.
%
% Syntax (hidden method)
% ------
%   is_correlation = correlation_inputchk(sim, measure);
%
% Details
% -------
% is_correlation = correlation_inputchk(sim, measure)
%   Returns a logical operator indicating whether the requested measure is
%   calculated using correlation or covariance. sim is a valid simuation
%   object, and measure is a 1x1 cell containing the name of the target
%   measure.
%
% Examples
% --------
%
% See also: simulate.ConvertMeasure, simulate.compute_correlation,
% simulate.compute

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 2:02:00 $

function is_correlation = correlation_inputchk(sim, measure)

func = sim.ConvertMeasure( measure );

corrlist = {'corrcoef','cov'};

is_correlation = false; % default.
for i = 1 : length(corrlist)
    f = strfind(func,corrlist{i});
    if ~isempty(f)
        is_correlation = true;
        return;
    end
end %i


end % correlation_inputchk