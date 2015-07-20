function [ timesStep, valuesStep ] = StepMarkovData( times, values )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
t = size(times);
timesStep = [];
valuesStep = [;];
t2 = t(2);
for i=2:t2
    timesStep = [timesStep, times(i-1), times(i)];
    valuesStep = [valuesStep, values(i-1), values(i-1)];
end

