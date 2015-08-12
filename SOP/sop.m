function [time,value] = sop(tspan,a,b,x, u0)
% Solve the problem using ode45
%[time,value] = ode45(@(t,u)[2*u/t],tspan,u0,0);
[time,value] = ode45(@f,tspan, u0);
function dudt = f(t,u)  

%dudt = (a/t+0.001)/(2*(b/t^(1/4)))*((u+(b/t^(1/4))+x)^(2)-(u-(b/t^(1/4)) - x)^(2));

%dudt = 2*u/t;

%dudt = (a/t)/(2*(b/t^(1/4)))*((u(1)+(b/t^(1/4))+x + 5)^(2) - (u(1)-(b/t^(1/4)) - x + 5)^(2));


%dudt = t^2;

%x =0;

dudt = (a/t)/(2*(b/t^(1/4)))*(((u^2+(b/t^(1/4))+x)*(u^2+(b/t^(1/4))-x))-x-((u^2-(b/t^(1/4))+x)*(u^2-(b/t^(1/4)-x))-x));

%syms t;
%ut = dsolve('Du=2*u/t', 'u(1)=1');

%dudt = cos(t)/t - u/t;

%dudt=1/(2*t^(1/4))*((u+t^(1/4))-(u+t^(1/4))^3-(u-t^(1/4))+(u-t^(1/4))^3);

end
end