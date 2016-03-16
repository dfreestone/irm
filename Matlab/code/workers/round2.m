


function x = round2( x, tol )

tol = 1/tol;
x = round( x*tol) / tol;