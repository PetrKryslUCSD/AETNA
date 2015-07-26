% Demonstration for the Stokes problem
function stokesdemo
    g=9.81;%m.s^-2
    r=0.005;%m
    eta=1100*1e-3;%1 Centipoise =1 mPa s 
    rhos=7.85e3;%kg/m^3
    rhof=1.10e3;%kg/m^3
    v0 = 0;% meters per second
    tspan =[0  0.5];% seconds
    options=odeset ('InitialStep',  0.1);% seconds
    [t,sol] = odebeul (@demorhs, tspan, [v0]', options);
    plot(t,sol(:,1), 'linewidth', 2, 'color', 'blue', 'marker', 'o'); hold on
    [x,y,u,v]=dirfield (@demorhs, 0, max(t), 0, 0.5, 10,10);
    quiver(x,y,u,v,3,'r.');
    t=linspace(tspan(1),tspan(2), 100);
    vt =(2*r^2*(rhos-rhof))/(9*eta)*g + (v0-(2*r^2*(rhos-rhof))/(9*eta)*g)*exp (-(9*eta)/(2*r^2*rhos)*t)
    plot(t,vt, 'linewidth', 2, 'color', 'black', 'marker', '.'); hold on
    xlabel('t [s]'),ylabel('v(t) [m/s]')
    hold off
    figure(gcf);
   
    function rhs=demorhs(t,v,flag,varargin)
        rhs= [(rhos-rhof)/rhos*g - (9*eta)/(2*r^2*rhos)*v(1)];
    end

end