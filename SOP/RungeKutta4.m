function [ t,u ] = RungeKutta4(t1, t2, u0, x, f)
%RUNGEKUTTA4 Summary of this function goes here
%   Detailed explanation goes here

dt = 0.001;
n = 1;
t(1) = t1;
u(1) = u0;

while t(n)<t2
    
    t(n+1) = t(n) + dt;
    k1 = f(u(n), t(n),x)*dt;
    k2 = f(u(n) + k1/2, t(n) + dt/2,x)*dt;
    k3 = f(u(n) + k2/2, t(n) + dt/2,x)*dt;
    k4 = f(u(n) + k3, t(n) + dt,x)*dt;
    phi = (1/6)*(k1 +2*k2 + 2*k3 +k4);
    
    %k2 = f(u(n) + k1/3, t(n) + dt/3,x)*dt;
    %k3 = f(u(n) + k2 - 1/3*k1, t(n) + 2*dt/3,x)*dt;
    %k4 = f(u(n) + k3 -k2 +k1, t(n) + dt,x)*dt;
    %phi = (1/8)*(k1 +3*k2 + 3*k3 +k4);
    
    
    if phi == 0
        yt = phi;
    end
    
    if u(n) < -10
        yt = phi;
    end
    
    u(n+1) = u(n) + phi;
    n = n+1;
end

end

function udot2 = f2(u,t,x)
  udot2 = 1/(2*t^(1/4))*((u+t^(1/4))^2-(u-t^(1/4))^2);
  %udot2 = 1/(2*t^(1/4))*((u+t^(1/4))-(u+t^(1/4))^3-(u-t^(1/4))+(u-t^(1/4))^3);
end

