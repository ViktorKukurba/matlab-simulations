function [t, u] = GetFunction(equation, times, values, funcIndex)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
t = [];
u = [];
n = length(times);


if funcIndex == 3
    ff = str2func(['@(t,x)' equation]);
else
    ff = str2func(['@(u,x)' equation]);
end

for i = 1:n-1 

    tStep1 = times(i);
    tStep2 = times(i+1);
    x = values(i);
    
    t = [t, [tStep1,tStep2]];
    u = [u, [ff(tStep1,x), ff(tStep2,x)]];
end

end

