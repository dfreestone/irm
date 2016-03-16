%SAMPLE_PRECISION sets the sample precision for the sampling algorithm.
%
% Syntax
% ------
%   sim.sample_precision(dr)
%
% Details
% -------
% Sets the sampling precision for the sampling algorithm. A small dr leads
% to high quality samples but hogs resources. A large dr leads to low
% quality samples. The default is dr = 0.00001.
% 
%  
% See also: simulate.get_samples

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 2:02:00 $
function sample_precision( sim, dr )
sim.dr = dr;
sim.r = -1 : sim.dr : 1;
end
