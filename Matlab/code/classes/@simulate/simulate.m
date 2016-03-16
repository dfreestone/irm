%SIMULATE class for simulation object.
%   sim = simulate(); constructs a simulation object.
%
% Methods:
% --------
%
% save()
%   Save a simulation (prompts for save location)
%
% load()
%   Load a simulation (prompts for load location)
%
% sample_precision(dr)
%   Set the sampling precision (r = -1:dr:1)
%
% get_samples()
%   Draws the random samples according to the IRM
%
% modify_input(input)
%   Sets the input measure variables (rho,N)
%
% add_measure(measure)
%   Adds a measure to the list of measures.
%
% edit_measure(measure)
%   Edits an existing measure
%
% remove_measure(measure)
%   Removes a measure
%
% result = compute(measure,[rows],[cols])
%   Computes the measure from the samples. rows and cols are optional
%   arguments that specify which samples to work on.
%
% result = compute_correlation(measure,[rows],[cols])
%   Computes the correlation (corrcoef) of measures. Measures must be
%   specified as [measure1,measure2,...,measureN]. rows and cols are
%   optional arguments that specify which samples to work on.
% 
%  
% See also: graph, interface

%   Copyright 2013
%   $Revision: 1.0 $  $Date: 2013/09/22 2:02:00 $

classdef simulate < handle
    
    % -------------------------------------------------------------------
    properties (Constant)
        MAX_cdfs  = 200;
        MAXPOINTS = 1e6;
    end % constant properties
    
    properties (GetAccess = 'public', SetAccess = 'public')
        
        progress
        notes = 'My notes...'
        saveName
        savePath
        
        npoints       = 1e4;
        randomsamples = {};
        ncdf = 0;
        use_cdf  = true;
        
        inputsVaried = false(6,3); % will be true where the inputs are varied.
        Input = ...
            {
            'r(s,s)'  , 1.0, 26
            'r(s,d)'  , 0.5, 26
            'r(s,i)'  , 0.5, 26
            'r(s,o)'  , 0.0, 26
            'r(s,<i>)', 0.5, 26
            'r(s,<o>)', 0.0, 26
            };
        
        measures = ...
            {
            'Self-Enhancement'           , 'r(s,d) - r(i,d)'
            'Differential Accuracy'      , 'r(i,<i>) - r(o,<o>)'
            'Ingroup Favoritism'         , 'r(i,d) - r(o,d)'
            'Intergroup Accentuation'    , 'r(i,o)'
            };
        
        
        
        
    end % public properties
    
    properties (GetAccess = 'public', SetAccess = 'private')
        r
        dr = 1e-5;
        rcdf = [];
    end % public get, private set.
    
    % -------------------------------------------------------------------
    % user actions should be public (naming_convention)
    methods (Access = public)
        
        % constructor...
        function sim = simulate()
            sim.sample_precision(sim.dr);
        end %
        
        % procedures...
        save(sim, overwrite)
        load(sim)
        sample_precision( sim, dr )
        get_samples(sim)
        modify_input( sim, measure )
        add_measure( sim, measure )
        edit_measure( sim, measure )
        remove_measure( sim, measure )
        
        % functions...
        m = irm_matrix(sim)
        result = compute(sim,measure,varargin)
        result = compute_correlation( sim, measure, varargin )
        is_correlation = correlation_inputchk(sim,measure)
    end % methods
    
    %user actions should be private (NamingConvention)
    methods (Access = private )
        m = ConvertMeasure( sim, measure )
        x = rrand( sim, rho, N, n, dx,x )
    end % private methods
    
end %classdef
