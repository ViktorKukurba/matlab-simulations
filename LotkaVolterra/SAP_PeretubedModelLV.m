function [t,y] = SAP_PeretubedModelLV(times, values, n0, p0,a,b,c,d,alpha, j, koef)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
n = size(times) - 1;
t = [0];
y = [n0;p0];
for i = 2:n(2)
    n0 = y(1, end);
    p0 = y(2,end);
    [t1, y1] = SAP_ModelLV([times(i) times(i+1)],[n0 p0],a+a*koef*values(i),b+b*koef*values(i),c+c*koef*values(i),d+d*koef*values(i),alpha,j);
    %[t1, y1] = ModelLV([times(i) times(i+1)],[n0 p0],a+a*0.5*values(i),b+b*0.5*values(i),c+c*0.5*values(i),d+d*0.5*values(i),j);
    t = [t, transpose(t1)];
    y = [y, transpose(y1)];
end

end