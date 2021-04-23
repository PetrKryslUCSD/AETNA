% Plot the reference solution of the Stokes problem.
function stokesref
    g=9.81;%m.s^-2
    r=0.005;%m
    eta=1100*1e-3;%1 Centipoise =1 mPa s
    rhos=7.85e3;%kg/m^3
    rhof=1.10e3;%kg/m^3
    v0 = 0;% meters per second
    tspan =[0  0.5];
    t=linspace(tspan(1),tspan(2), 100);
    vt =(2*r^2*(rhos-rhof))/(9*eta)*g +...
        (v0-(2*r^2*(rhos-rhof))/(9*eta)*g)*exp (-(9*eta)/(2*r^2*rhos)*t);
    plot(t,vt, 'linewidth', 2, 'color', 'black', 'marker', '.'); hold on
    xlabel('t [s]'),ylabel('v(t) [m/s]')
end