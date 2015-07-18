function [time,value] = ModelLV(t,x,a,b,c,d,j)
[time,value] = ode45(@MLVSolver,t,x);
function f=MLVSolver(t,x)
    f=[(a*x(1)-b*x(1)*x(2)-j*x(1)*x(1));
   (-d*x(2)+c*x(1)*x(2)-j*x(2)*x(2))];
end
end