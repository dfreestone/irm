%UPDATEMODIFYINPUT updates the current simulation object and interface to
% reflect a new user-specified simulation.
%
% Syntax
% ------
%  ui.UpdateModifyInput( sim,gr );
%
% Details
% -------
% Modifies the selected input parameter according to user-specification, 
% runs a new simulation, and displays this simulation in the interface 
% window.
% 
% Examples
% --------
%  
% See also: interface.update_axes, interface.modify_input

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 19:48:00 $ 

function UpdateModifyInput(ui,sim,gr)

% update message center
ui.message_center( 'g', 'Updating selection...' );

% update the modifyInput_editbox
% ----------------------------------------------------------------
set( ui.handles.modifyInput_txtbox, 'String', sprintf('Modify %s {r,N}',ui.currentlyActiveInput) );
m = sim.irm_matrix();
[r,c] = find(strcmpi(m,ui.currentlyActiveInput));
set( ui.handles.input_txt(ui.handles.input_txt>0), 'FontWeight', 'normal' );
set( ui.handles.input_txt(r,c), 'FontWeight', 'bold' );

f = strcmpi( ui.currentlyActiveInput, sim.Input(:,1) );
if any(f)
    rho = sim.Input{f,2};
    N   = sim.Input{f,3};
    enable = 'on';
else
    mu_func = sprintf( 'mean(%s)', ui.currentlyActiveInput );
    sd_func = sprintf( 'std(%s)' , ui.currentlyActiveInput );
    rho = cell2mat( sim.compute(mu_func) );
    N   = cell2mat( sim.compute(sd_func) );
    enable = 'off';
end
if isscalar( rho )
    txt_rho = sprintf('%1.2f',rho);
else
    txt_rho = sprintf( '[%1.2f : %1.3f : %1.2f]', nanmin(rho), mean(diff(rho)), nanmax(rho) );
end % isscalar( rho )

if isscalar( N )
    if any(f), txt_N = sprintf('%d',N);
    else txt_N = sprintf('%1.2f',N);
    end % any(f) inside isscalar
else
    txt_N = sprintf( '[%1.0f : %1.0f : %1.0f]', nanmin(N), mean(diff(N)), nanmax(N) );
end % isscalar( rho )

formatStr = sprintf( '{ %s, %s }', txt_rho, txt_N );
set( ui.handles.modifyInput_editbox, 'String', formatStr, 'Enable', enable );

% get x and y labels here...and set it as "options"
% then pass in options into plot.

[x_label, y_label, z_label] = gr.modifyInput_axes.get_labels( sim, ui.currentlyActiveInput );
options = gr.modifyInput_axes.options_from_labels(x_label, y_label, z_label);
gr.modifyInput_axes.plot( sim, m{r,c}, options );

% update message center
ui.message_center( 'g', 'Modify the input measure using the edit box.' );

end                  % UpdateModifyInput
