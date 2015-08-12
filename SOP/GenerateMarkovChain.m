function [ time, valueX ] = GenerateMarkovChain(startTime, endTime, states)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
time = [];
valueX = [];
pd = makedist('Exponential');
timeVal = pdf(pd, 1);
cummulativeTime = startTime;

while endTime>cummulativeTime

r1 = unifrnd(0,1);
len = length(states);

for i = 1:len
val = i/len;
if r1 < val
    state = states(i);
    break;
end
end
 cummulativeTime = cummulativeTime + timeVal();
 time = [time, cummulativeTime];
 valueX = [valueX, state];
end
end

