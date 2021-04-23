% Built-in numerical solution of the Stokes problem, vector formulation
g=9.81;%m.s^-2
r=0.005;%m
eta=1100*1e-3;%1 Centipoise =1 mPa s
rhos=7.85e3;%kg/m^3
rhof=1.10e3;%kg/m^3
z0 = [0;0];% Initial distance and velocity, meters per second
tspan =[0  0.5];% seconds
f=@(t,z)([z(2); (rhos-rhof)/rhos*g-(9*eta)/(2*r^2*rhos)*z(2)]);
[t,z] = ode23 (f, tspan, z0);
plot(t,z,'o-')
xlabel('t [s]'),ylabel('x(t) [m], v(t) [m/s]')
    