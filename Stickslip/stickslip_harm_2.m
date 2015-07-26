%
% Coulomb (Dry) friction 
%
function  [t,y] =stickslip_harm_2
    y0 =[0.0;0.0];
    tspan = [0,0.6];
    options = odeset('RelTol',1e-6,'AbsTol',1e-4,'InitialStep', 0.00001);
    [t,y] =odebeul(@stickslip_harm_2_rhs, tspan, y0, options);

    figure
    plot(t,y(:,1),'k-'); hold on
    plot(t,y(:,2),'k--'); hold on
    xlabel('t [s]'),ylabel('v(t),[m/s], x(t)[m]')
    grid on
end