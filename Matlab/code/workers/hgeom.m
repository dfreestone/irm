% hgeom
% Creation Date: 6.19.2012
%    Written By: David Freestone (DMF)
%                Patrick Heck    (PH)
%
% Purpose: Approximates the hypergeometric function.
%
%
% Copyright Information xxx
%
%
% CHANGELOG:
% ----------
%
% DMF 04.20.2013: Maintenance.
% DMF 11.xx.2012: Uses a more accurate method / stopping algorithm
%                 GIVE REFERENCE HERE!!!
% DMF 6.19.2012 : Created.
function F = hgeom( a, b, c, z, tol )

% initalize
C = ones( size(z) );
F = ones( size(z) );
% place of max z is gonna be the hardest to reject
% MUST CHECK THIS FACT.
[~,mxz] = max( z(:) );

% set stopping rules and counter
tolChecksComplete = 0; % must be static for 3 steps.
j = 0;

while tolChecksComplete < 3
    
    C = C .* (((a+j)*(b+j))./(c+j)) .* z./(j+1);
    
    check = C(mxz) ./ F(mxz); % This is supposed to be abs(C)./abs(F), but there are no negative numbers. So this is faster.
    %     check = max( check(:) );
    
    if check<tol %#ok<BDSCI>
        tolChecksComplete = tolChecksComplete + 1;
    end
    
    F = F + C;
    
    j = j + 1;
    
end %~done