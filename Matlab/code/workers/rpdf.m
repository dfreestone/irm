% rpdf
% Creation Date: 6.19.2012
%    Written By: David Freestone (DMF)
%                Patrick Heck    (PH)
%
% Purpose: Computes the PDF of the r-distribution for a single {rho,N} pair
%
%
% Copyright Information xxx
%
%
% CHANGELOG:
% ----------
%
% DMF 04.20.2013: Maintenance.
% DMF 6.19.2012 : Created.
function y = rpdf(r, rho, n)

gam_ratio = gamma( n-1 ) ./ gamma(n-0.5);

k_ratio = (n-2) ./ sqrt(2*pi);

rho_ratio = (1 - rho.^2) .^((n-1)/2) ...
    .* (1 - r.^2)   .^((n-4)/2) ...
    .* (1 - rho.*r) .^((3/2) - n);

F = hgeom( 0.5, 0.5, n-0.5, (1+rho.*r)/2, 1e-15 );

y = k_ratio .* gam_ratio .* rho_ratio .* F;
