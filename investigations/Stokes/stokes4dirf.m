% Illustration of the direction field
function stokesdirf
    g=9.81;%m.s^-2
    r=0.005;%m
    eta=1100*1e-3;%1 Centipoise =1 mPa s 
    rhos=7.85e3;%kg/m^3
    rhof=1.10e3;%kg/m^3
    for v0 = [0];% meters per second
        tspan =[0  0.7];% seconds
        t=linspace(tspan(1),tspan(2), 100);
        vt =(2*r^2*(rhos-rhof))/(9*eta)*g + (v0-(2*r^2*(rhos-rhof))/(9*eta)*g)*exp (-(9*eta)/(2*r^2*rhos)*t)
        plot(t,vt, 'linewidth', 2, 'color', 'black', 'marker', '.'); hold on
    end
    [x,y,u,v]=dirfield (@stokesrhs, 0, max(t), 0, 0.5, 20,20);
    quiver(x,y,u,v, 2.5,'r.'); hold on
    xlabel('t [s]'),ylabel('v(t) [m/s]')
    hold off
    figure(gcf);
   
    function rhs=stokesrhs(t,v,flag,varargin)
        rhs= [(rhos-rhof)/rhos*g - (9*eta)/(2*r^2*rhos)*v(1)];
    end

end