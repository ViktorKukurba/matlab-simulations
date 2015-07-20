function [t, u] = SolveSOP( times, values,a,b, u0 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
t = [times(1)];
u = [u0];
n = length(times);
for i = 1:n-1 
    u0 = u(1, end);
    tStep1 = times(i);
    tStep2 = times(i+1);
    x = values(i);
    [t1, u1] = sop([tStep1 tStep2],a,b, x, u0);
    t = [t, transpose(t1)];
    u = [u, transpose(u1)];
end

end

