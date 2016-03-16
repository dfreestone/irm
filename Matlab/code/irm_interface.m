% Script rather than function so 'base' is easy.
clear all;
close all;
clc;

try
    addpath('workers');
    addpath('classes');
    addpath('windows');
    
    ui = interface('New');
catch me
    
    ui.error('IRM:Unknown', 'Unknown Error. Check log.');
    
    msgID = me.identifier;
    msg = me.message;
    stack = me.stack;
    ui.WriteLog(msgID, msg);
    for i = 1 : length(stack)
        ui.WriteLog('\t', sprintf('%s (line %s)',stack(i).name,stack(i).line));
    end
end