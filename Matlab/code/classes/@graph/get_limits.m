%GET_LIMITS obtains the maximum and minimum values to use when plotting 
%simulated data.
%
% Syntax
% ------
% lims = ui.get_limits( x, factor )
%
% Details
% -------
% This function returns a 1x2 matrix containing the minimum and maximum
% to use as limits on the x- and y-axis. x is a vector of varied values and
% factor is a percentage value above (below) the max (min) value of x that
% will be displayed.
%
% Examples
% --------
%  

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 17:30:00 $  

function lims = get_limits( ~, x, factor )

range = (max(x) - min(x));

halfWidth = (factor * range) / 2;

maxx = max(x) + halfWidth;
minx = min(x) - halfWidth;

lims = [minx,maxx];
end % get_lims
