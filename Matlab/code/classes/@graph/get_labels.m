function [x_label, y_label, z_label] = get_labels( ~, sim, measure )

y_label = [];
z_label = [];
% (always sends back and x_label);

[varied,isN] = sim.get_varied();
n = size(varied,1);

if n==0 % nothing varied
    x_label = measure;
    
else % 1+ varied.
    labels = varied(:,1);
    labels(isN) = strrep( labels(isN), 'r', 'N' );
    
    if n==1 % 1 varied
        x_label = labels{1};
        y_label = measure;
    else % 2 varied
        x_label = labels{1};
        y_label = labels{2};
        z_label = measure;
    end % length(row)
end % isempty(row)

end % get_labels
