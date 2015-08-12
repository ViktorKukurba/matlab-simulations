function [t, u, tt, uu] = SolveSOP(equation, times, values,a,b, u0, isMin)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
t = [times(1)];
u = [u0];
n = length(times);

tt = [times(1)];
uu = [u0];

strF = getGradient(equation);
d1 = '(at/(2*bt))';
finalFunc = strcat(d1, '*', strF);
ff = str2func(['@(u,t,x,at,bt)' finalFunc]);

    function udot = SOProcedure(u,t,x)
        at = a/t;
        %x = 0;
        bt = b/(t^(1/4));
        udot = ff(u,t,x,at,bt);
    end



for i = 1:n-1 
    u0 = u(1, end);
    %uu0 = uu(1, end);
    tStep1 = times(i);
    tStep2 = times(i+1);
    x = values(i);
    [t2, u2] = RungeKutta4(tStep1, tStep2, u0, x, @SOProcedure);
    %[t1, u1] = ode45(@(t,y)SOProcedure(t,y,x),[tStep1, tStep2], u0);
    
    %[T,Y]=odeXX(@(t,y)evalfcn(t,y,arg1,arg2,...),tspan,y0,options)
    
    %t = [t, transpose(t1)];
    %u = [u, transpose(u1)];
    t = [t, t2];
    u = [u, u2];
end

function gradient = getGradient(strfunc)
    if (isMin)
        gradient = strcat('(',strrep(strfunc, 'u', '(u-bt)'),'-',strrep(strfunc, 'u', '(u+bt)'), ')');
    else
        gradient = strcat('(',strrep(strfunc, 'u', '(u+bt)'),'-',strrep(strfunc, 'u', '(u-bt)'), ')');
    end

end

function udot = f(u,t,x)
strF = getGradient('(u + x )^2');
ff = str2func(['@(u,t,x,bt)' strF]);

at = 1/t;

bt = 1/(t^(1/4));
d1 = (at/(2*bt));

%t1 =  d1*((u - bt +x)^2 - (u + bt +x)^2);
%t2 =  d1*((u^2 + bt +x)^2 - (u^2 - bt +x)^2);
%t3 =  d1*((u - bt + x - 20)^2 - (u + bt + x -20)^2);


%gradVal = eval(strF);
gradVal = ff(u,t,x,bt);
%eval(strcat('t4 = ', '(u+bt)', ';'));
%t5 = t4 * 2;

udot = d1*gradVal;%d1*((u + bt +x)^2 - (u - bt +x)^2);

end

end

