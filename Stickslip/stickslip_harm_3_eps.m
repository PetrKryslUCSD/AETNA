% Explain the diverging solutions using the direction field.
function stickslip_harm_3_forward
    yspan = [-0.06, 0.06];
    tspan = [-0.03, 0.05];
    options = odeset('RelTol',1e-6,'AbsTol',1e-4,'InitialStep', 0.00001,'MaxStep', 0.01);
    rhs=@stickslip_harm_1_rhs;

%     [t,y] =odefeul(rhs, tspan, y0, options);
%     plot(t,y(:,1),'k-'); hold on
    clear t y

    [x,v,fx,fv]=dirfield (rhs, tspan(1), tspan(2),yspan(1), yspan(2), 50,41);
    quiver(x,v,fx,fv, 2.5,'ro','markersize',2); hold on
    xlabel('t [s]'),ylabel('v(t) [m/s]')
    hold on
    figure(gcf);
    set(gca,'xlim', range(tspan));
    set(gca,'ylim', yspan);
    Styles = {'k-','g--','b-.','k-'};
    v0s(1) =[-0.048222212540824];
    v0s(2) =[v0s(1)-10*eps];
    v0s
    for v0 = v0s
        y0 =[v0];
        [t,y] =odefeul (@stickslip_harm_1_rhs, tspan, y0, options);
        plot(t,y,Styles{end}); hold on
        xlabel('t [s]'),ylabel('v(t) [m/s]')
        grid on
        Styles = Styles(1:end-1);
    end
end