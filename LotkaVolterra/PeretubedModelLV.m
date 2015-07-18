function [t,y] = PeretubedModelLV(times, values, n0, p0,a,b,c,d,j, perturbKoef)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
n = size(times) - 1;
t = [];
y = [;];
for i = 1:n(2)
    if size(t) ~= 0
        n0 = y(1, end);
        p0 = y(2,end);
    end
    
    [t1, y1] = ModelLV([times(i) times(i+1)],[n0 p0],a+a*perturbKoef*values(i),b+b*perturbKoef*values(i),c+c*perturbKoef*values(i),d+d*perturbKoef*values(i),j);
    t = [t, transpose(t1)];
    y = [y, transpose(y1)];
end

end

