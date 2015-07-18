function [time,value] = SAP_ModelLV(t,x,a,b,c,d,alpha,j)
[time,value] = ode45(@MLVSAPSolver,t,x);
function f=MLVSAPSolver(t,x)
    f=[(alpha/t)*(a*x(1)-b*x(1)*x(2)-j*x(1)*x(1));
   (alpha/t)*(-d*x(2)+c*x(1)*x(2)-j*x(2)*x(2))];
end
end