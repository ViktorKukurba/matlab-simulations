function [ time, valueX ] = GenerateMarkovChain(startTime, endTime)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
states = [-1 0 1];
time = [0];
valueX = [0];
result = [0];
pd = makedist('Exponential');
timeVal = pdf(pd, 1);
cummulativeTime = startTime;

while endTime>cummulativeTime

r1 = unifrnd(0,1);

 if r1 < 1/3
     state = -1;
 elseif r1 < 2/3
     state = 0;
 else
     state = 1;
 end
 cummulativeTime = cummulativeTime + timeVal();
 time = [time, cummulativeTime];
 valueX = [valueX, state];
end
end

