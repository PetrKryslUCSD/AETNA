% Backward Euler solution
clear all
g=9.81;%m.s^-2
r=0.005;%m
eta=1100*1e-3;%1 Centipoise =1 mPa s
rhos=7.85e3;%kg/m^3
rhof=1.10e3;%kg/m^3
v0 = 0;% meters per second
tspan =[0  0.5];% seconds
f=@(t,v)((rhos-rhof)/rhos*g - (9*eta)/(2*r^2*rhos)*v);
options =odeset('initialstep', 0.01);
[t,v] = odebeul(f, tspan, [v0]', options);
plot(t,v,'o-')
xlabel('t [s]'),ylabel('v(t) [m/s]')
    
    