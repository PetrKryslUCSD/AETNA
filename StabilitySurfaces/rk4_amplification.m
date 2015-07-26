% Calculate an analytical expression for the amplification factor of the RK4
clear all
syms dt lambda y0 y real
f=@(y)lambda*y;
k1=f(y0)
k2 =f(y0+dt/2*k1)
k3 =f(y0+dt/2*k2)
k4 =f(y0+dt*k3)
y=y0+dt/6*(k1+2*k2+2*k3+k4)
simple(simple(y)-y0*(1+dt*lambda +(dt*lambda)^ 2/2+(dt*lambda)^3/6+(dt*lambda)^ 4/24))
