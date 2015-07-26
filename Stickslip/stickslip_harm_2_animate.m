% Visualization of the motion of the eccentric mass shaker
%
function  stickslip_harm_2_animate
    [m,mus,mud,N,A,omega,vstick] = stickslip_harm_data;
    y0 =[0.0;0.0];
    tspan = [0,0.6];
    xspan = [-0.07, 0.07];
    options = odeset('RelTol',1e-6,'AbsTol',1e-4,'InitialStep', 0.00001);
    [t,y] =odefeul(@stickslip_harm_2_rhs, tspan, y0, options);

    figure
    plot(t,y(:,1),'k:'); hold on
    plot(t,y(:,2),'k-'); hold on
    xlabel('t [s]'),ylabel('v(t),[m/s], x(t)[m]')
    grid on

    Animate;

    function Animate
        Width = 0.07;
        Height = 0.07;
        RadiusI = 0.4*Height;
        RadiusW =0.4*RadiusI;
        Black = [0,0,0];
        White = [0,0,0]+1;
        Gray = [0,0,0]+0.7;

        Frame=GPath_polygon([xspan(1)-Width,-Height;xspan(2)+Width, Height]);
        Frame.edgecolor ='w';
        Frame.color = [];
        Frame.linestyle ='none';
        Frame.linewidth =1;

        Ground=glyph_rectangle([4*Width,2*Height],Gray,Gray);
        Ground =translate (Ground,[0,-1.5*Height]);

        Box=glyph_rectangle([Width,Height],Black,Black);

        Interior= glyph_circle(2*RadiusI,White,White);
       
        Weight= glyph_circle(2*RadiusW,Black,Black);


        f=figure; hold on
        set(gca,'Units','centimeter')
        for i =1:100:length(t)
            figure(f);
            cla
            render(Frame);
            render(Ground);
            render(translate(Box,[y(i,2),0]));
            render(translate(Interior,[y(i,2),0]));
            render(translate(Weight,[y(i,2),0]+(RadiusI-RadiusW)*[cos(omega*t(i)),sin(omega*t(i))]));

            axis equal
            % grid on
            axis off
            drawnow; pause (0.01);
        end
    end
end