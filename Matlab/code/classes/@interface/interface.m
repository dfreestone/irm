%INTERFACE class for interface object.
% ui = interface(); constructs an interface object.
% 
% All methods in interface.m are hidden.
% 
% See also: simulate, graph

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 2:02:00 $

classdef interface < handle
    
    % -------------------------------------------------------------------
    properties (Constant, GetAccess = private)
        VERSION = 1.0
    end % constant properties
    
    properties %(GetAccess = private)
        
        % handles...
        uihandle
        handles
        
        % variables...
        currentlyActiveInput = 'r(s,d)'; % default to first one.
        fontSize = 12;
        fontName = 'Arial';
        
        plots = {}; % name, plottype, rows, columns
        graphs % list of all user defined graph objects
    end % private properties
    
    % -------------------------------------------------------------------
    % constructor and user actions should be public (naming_convention)
    methods (Access = public)
        
        % constructor...
        function ui = interface(~)
            ui.uihandle = open( 'userInterface.fig' );
            ui.GetHandles();
            ui.SetCallbacks();
            ui.new();
        end  % interface
    end % public methods
    
    % internal functions are private (NamingConventionType)
    methods (Access = private)
        
        new(ui)
        save(sim,overwrite)
        open(ui)
        exit(varargin)
        
        click(varargin)
        
        remove_measure(varargin)
        edit_measures(varargin)
        
        add_plot(varargin)
        remove_plot(varargin)
        
        plot_selected(varargin)
        plot_all(varargin)
        plot_tools(varargin)
        
        modify_input(varargin)
        
        % menu items
        file_menu(varargin)
        options_menu(varargin)
        help_menu(varargin)
        modify_notes(ui,sim)
        modify_npoints(ui,sim)
        
        % misc. public functions
        message_center( ui, color, message )
        populate_lists( ui, sim, gr )
        update_axes(ui,sim,gr)
        error(ui, msgId, msgStr )
        
        % procedures
        WriteLog( ~, msgId, msgStr )
        GetHandles(ui)
        SetCallbacks(ui)
        PopulatePlottypesDropdown(ui,gr)
        PopulateMeasuresListbox(ui,sim)
        PopulatePlotsListbox(ui)
        UpdateModifyInput(ui,sim,gr)
        
        
        % functions
        gr = CreateUIGraphics(ui)
        [sim,gr] = CallSimulationAndGraphObjects(ui)
        
        % =======================================================================
        
    end % private methods
end %classdef
