
function dydt = vanderpoldemo2(t,y,Mu)
%VANDERPOLDEMO Defines the van der Pol equation for ODEDEMO.

% Copyright 1984-2014 The MathWorks, Inc.

dydt = [Mu*(1-y(1)^2)*y(2)-y(1)];
end


