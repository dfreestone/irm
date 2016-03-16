%RRAND samples from the correlation coefficient distribution
% 
% Syntax (hidden method)
% ----------------------
%   x = sim.rrand( sim, rho, N, n, dr,r )
%
% Details
% -------
% The user cannot access this function directly.
% Will store computed distributions for later use if sim.use_cdf is true.
% 
%  
% See also: simulate.get_samples

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 2:02:00 $

function x = rrand( sim, rho, N, n, dr,r )


if abs(rho)==1 || N<=0
    x(n,1) = 0;   % uses super fast preallocation...3x faster than rho*ones
    x = rho + x;
    return;
end

du = 1e-4;
u = rand(n,1); % U(0,1)
u = round( u/du ) * du; % round to du precision

% use and store cdfs if requested...else compute.
ind = 0;
if sim.use_cdf && ~isempty( sim.rcdf )
    ind = (sim.rcdf(:,1)==rho) & (sim.rcdf(:,2)==N);
end

if sum(ind)>0
    ycdf = sim.rcdf( ind, 3:end );
else
    y  = dr * rpdf( r, rho, N );
    ycdf = cumsum( y );
    ycdf = round( ycdf/du ) *du; % round the cdf to du precision
    if sim.use_cdf
        if sim.ncdf>sim.MAX_cdfs, sim.ncdf = 0; end
        sim.ncdf = sim.ncdf + 1;
        sim.rcdf(sim.ncdf,:) = [rho, N, ycdf];
    end % inner sim.use_cdf
end % outer sim.use_cdf

loc = ismembc2( u, ycdf ); % ycdf is already sorted, so we can call ismembc2 directly
loc = loc(loc>0);
x = r( loc );
end % rrand
