function [time,value] = sop(tspan,a,b,x, u0)
% Solve the problem using ode45
[time,value] = ode45(@f,tspan,u0);
%[time,value] = ode45(@MLVSOPSolver,tspan, y0);
function dudt = f(t,u)  

%dudt = (a/t+0.001)/(2*(b/t^(1/4)))*((u+(b/t^(1/4))+x)^(2)-(u-(b/t^(1/4)) - x)^(2));

%dudt = 2*u/t;

%dudt = (a/t)/(2*(b/t^(1/4)))*((u+(b/t^(1/4))+x + 5)^(2) - (u-(b/t^(1/4)) - x + 5)^(2));


%dudt = t^2;

dudt = (1/t)/(2*(1000/t^(1/4)))*(((u+(1000/t^(1/4))+x)*(u+(1000/t^(1/4))+x))-x-((u-(1000/t^(1/4))+x)*(u-(1000/t^(1/4))+x))-x);

end
end