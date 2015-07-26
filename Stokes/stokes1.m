% First numerical solution of the Stokes problem
g=9.81;%m.s^-2
r=0.005;%m
eta=1100*1e-3;%1 Centipoise =1 mPa s
rhos=7.85e3;%kg/m^3
rhof=1.10e3;%kg/m^3
v0 = 0;% meters per second
tspan =[0  0.5];% seconds
f=@(t,v)((rhos-rhof)/rhos*g - (9*eta)/(2*r^2*rhos)*v);
nsteps =20;
dt= diff(tspan)/nsteps;
t(1)=tspan(1);
v(1)=v0;
for j=1:nsteps
    t(j+1) =t(j)+dt;
    v(j+1) =v(j)+dt*f(t(j),v(j));
end
plot(t,v,'o')
xlabel('t [s]'),ylabel('v(t) [m/s]')
set(gca, 'xlim', [min(t),max(t)])    