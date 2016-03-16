
% A neat little diddy I found on FEX
% idea came from a guy named Kelly Kearney

function color = lighten_color( color, factor )

if isempty( color )
    return;
end

color = interp1([0 1], [1 1 1; color], factor);