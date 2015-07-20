function [time,value] = sop(t,a,b)
tspan = [0 12];
u0 = [0];
% Solve the problem using ode45
[time,value] = ode45(@f,tspan,u0);
%[time,value] = ode45(@MLVSOPSolver,tspan, y0);
function dudt = f(t,u)  
dudt = [ (1/t)/(2*(1/t^4))*(((u+1/t^4)+2)^2 - ((u-1/t^4)+2)^2)];
end
end