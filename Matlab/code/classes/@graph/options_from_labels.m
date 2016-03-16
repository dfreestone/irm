function  options = options_from_labels(~, x_label, y_label, z_label)

options = { 'xlabel', {'String', x_label} };

if ~isempty(y_label)
    options = [options; { 'ylabel', {'String', y_label} }];
    if ~isempty(z_label)
        options = [options; { 'zlabel', {'String', z_label} }];
    end % z_label
end % y_label

end % options_from_labels
