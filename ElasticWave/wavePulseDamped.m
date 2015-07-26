% Elastic 1D wave, damped. Numerical integration
function wavePulseDamped
    npart= 159;
    % MPa    tonne/mm^3      mm^2    mm
    E=200000; rho=7.85e-9; A=200; L=7850; Ihat =1;
    h=L/(npart-1);% element length
    m= A*rho*h;  k = E*A/h;   c = 0.00001*k;
    M = diag(ones(1,npart))*m;% mass matrix
    M(1,1) =m/2;
    M(npart,npart) =m/2;
    S = diag(ones(1,npart))*3 -tril(triu(ones(npart),-1),+1);
    S(1,1) =1;
    S(npart,npart) =1;
    K =k*S;% stiffness matrix
    C = c*S;% damping matrix
    T =2e-4;% duration of forcing in seconds
    F =zeros(npart,1); F(1) =Ihat*pi/T/2;% force distribution
    function out=rhs(t, y, varargin)
        out = [y(npart+1:2*npart); ...
            inv(M)*(-K*y(1:npart)-C*y(npart+1:2*npart)...
            +F*(t<T)*sin(pi*t/T))];
    end
    %     sigmax =Ihat*pi/T/2/A;% maximum stress in MPa
    [V,D]=eig(K,M);
    max_omega=sqrt(max(abs(diag(D))))
    min_omega=sqrt(min(abs(diag(D))))
    dt= (2*pi/max_omega)/4;
    nsteps = round(2.4*L/(sqrt(E/rho))/dt);% how many steps?
    tspan= [0,nsteps*dt];
    y0(1:npart,1)=   zeros(npart,1);%init. [disp,velocity]
    y0(npart+1:2*npart,1) =  zeros(npart,1);
    options =odeset('InitialStep',dt);
    [t,y]=odetrap(@rhs,tspan,y0,options);style ='r-';
    %     [t,y]=ode23t(@rhs,tspan,y0,options);style ='g-';
    %     [t,y]=ode23tb(@rhs,tspan,y0,options);style ='g-';
    %     [t,y]=ode23(@rhs,tspan,y0,options);style ='m-';
    %     [t,y]=ode45(@rhs,tspan,y0,options);style ='g-';
    %         [t,y]=ode113(@rhs,tspan,y0,options);style ='b--';
    nsteps =length(t);
    % Enable one of the postprocessing options below
    Spring_animate
    %     Displacement_animate
    %     Stress_animate; hold on
    %     Displacement_velocity_subplots([1,round(npart/2)+1,npart,npart+1,npart+round(npart/2)+1,2*npart]); hold on
    %     Spring_subplots([round((1:4:37)/37*nsteps)]); hold on
    %     Displacement_subplots([round(1*nsteps/16),round(5*nsteps/16),round(9*nsteps/16)]); hold on
    %     Stress_subplots([round(1*nsteps/16),round(5*nsteps/16),round(9*nsteps/16)]); hold on
    %     Energy_subplots; hold on
    %     Displacement_surface
    figure (gcf);

    function Displacement_velocity_subplots(i)
        ylimit =[0, 0.5];
        subplot(3,2,1)
        plot(t,y(:,i(1)),style); ylabel(['y(' num2str(i(1)) ')']); grid on; hold on
        set(gca,'xlim',tspan);
        set(gca,'ylim',ylimit);
        subplot(3,2,3)
        plot(t,y(:,i(2)),style); ylabel(['y(' num2str(i(2)) ')']);grid on; hold on
        set(gca,'xlim',tspan);
        set(gca,'ylim',ylimit);
        subplot(3,2,5)
        plot(t,y(:,i(3)),style); ylabel(['y(' num2str(i(3)) ')']); grid on; hold on
        set(gca,'xlim',tspan);
        set(gca,'ylim',ylimit);
        xlabel ('t');
        ylimit =[-1,1]*2e3;
        subplot(3,2,2)
        plot(t,y(:,i(4)),style); ylabel(['y(' num2str(i(4)) ')']); grid on; hold on
        set(gca,'xlim',tspan);
        set(gca,'ylim',ylimit);
        subplot(3,2,4)
        plot(t,y(:,i(5)),style); ylabel(['y(' num2str(i(5)) ')']); grid on; hold on
        set(gca,'xlim',tspan);
        set(gca,'ylim',ylimit);
        subplot(3,2,6)
        plot(t,y(:,i(6)),style); ylabel(['y(' num2str(i(6)) ')']); grid on; hold on
        set(gca,'xlim',tspan);
        set(gca,'ylim',ylimit);
        xlabel ('t');
    end

    function Stress_subplots(i)
        ylimit =[-1,1]*45;
        subplot(3,1,1)
        plot((0+h/2:h:L),E*diff(y(i(1),1:npart))/h,style);
        set(gca,'xlim',[0,L]);  set(gca,'ylim',ylimit);
        ylabel(['\sigma(x,' num2str(1e3*t(i(1)),2) '\times10^{-3})']); grid on; hold on
        subplot(3,1,2)
        plot((0+h/2:h:L),E*diff(y(i(2),1:npart))/h,style);
        set(gca,'xlim',[0,L]);  set(gca,'ylim',ylimit);
        ylabel(['\sigma(x,' num2str(1e3*t(i(2)),2) '\times10^{-3})']);grid on; hold on
        subplot(3,1,3)
        plot((0+h/2:h:L),E*diff(y(i(3),1:npart))/h,style);
        set(gca,'xlim',[0,L]);    set(gca,'ylim',ylimit);
        ylabel(['\sigma(x,' num2str(1e3*t(i(3)),2) '\times10^{-3})']); grid on; hold on
        xlabel ('x');
    end

    function Displacement_subplots(i)
        ylimit =[0,1]*0.5;
        subplot(3,1,1)
        plot((0:h:L),y(i(1),1:npart),style);
        set(gca,'xlim',[0,L]);  set(gca,'ylim',ylimit);
        ylabel(['u(x,' num2str(1e3*t(i(1)),2) '\times10^{-3})']); grid on; hold on
        subplot(3,1,2)
        plot((0:h:L),y(i(2),1:npart),style);
        set(gca,'xlim',[0,L]);  set(gca,'ylim',ylimit);
        ylabel(['u(x,' num2str(1e3*t(i(2)),2) '\times10^{-3})']);grid on; hold on
        subplot(3,1,3)
        plot((0:h:L),y(i(3),1:npart),style);
        set(gca,'xlim',[0,L]);    set(gca,'ylim',ylimit);
        ylabel(['u(x,' num2str(1e3*t(i(3)),2) '\times10^{-3})']); grid on; hold on
        xlabel ('x');
    end


    function Energy_subplots
        PE = 1/2*dot(y(:,1:npart)',K*y(:,1:npart)');
        KE = 1/2*dot(y(:,npart+1:end)',M*y(:,npart+1:end)');
        TE =PE +KE;
        subplot(3,1,1)
        plot(t,PE,style); ylabel(['PE(t)']); grid on; hold on
        subplot(3,1,2)
        plot(t,KE,style); ylabel(['KE(t)']); grid on; hold on
        subplot(3,1,3)
        plot(t,TE,style); ylabel(['TE(t)']); grid on; hold on
        xlabel ('t');
    end

    function Displacement_animate
        ylimit =[0, 0.5];
        for i = 1:length(t)
            plot((0:h:L),y(i,1:npart),style);
            set(gca,'ylim',ylimit);
            set(gca,'xlim',[0,L]);
            xlabel ('x');ylabel('u');grid on;
            pause(0.01);
        end
        ylabel('u'); grid on; hold on
        xlabel ('x');
    end

    function Stress_animate
        ylimit =[-1,1]*45e0;
        for i = 1:length(t)
            plot((0+h/2:h:L),E*diff(y(i,1:npart))/h,style);
            set(gca,'ylim',ylimit);
            set(gca,'xlim',[0,L]);
            xlabel ('x');ylabel('\sigma');grid on;
            pause(0.01);
        end
        xlabel ('x'); ylabel('\sigma'); grid on; hold on
    end

    function Displacement_surface
        surf(t,(0:h:L),y(:,1:npart)', 'FaceColor', 'interp', 'EdgeColor', 'none');
        hold on;
        camlight headlight ;
        contour3(t,(0:h:L),y(:,1:npart)', 10, 'k-');
        light('Position',[-1e-4 -8000 6],'Style','infinite');
        set(gca,'xlim',tspan);
        set(gca,'ylim',[0,L]);
        set(gca,'zlim',[0, 0.5]);
        grid on; hold on
        labels ('$t$','$x$','$u$');
    end

    function Spring_subplots(i)
        Scale =4e3;
        W =10;
        SpringX =linspace(0,L,npart);
        SpringY =linspace(0,L,npart);
        SpringY(1:2:end) =W;
        SpringY(2:2:end) =-W;
        for j=1:length(i)
            subplot(length(i),1,j)
            l=line(SpringX +Scale*y(i(j),1:npart),SpringY);
            set(l,'linewidth',1)
            set(l,'color',[0, 0, 0])
            ylabel(['']); grid on; hold on
            set(gca,'xlim', [0,L+Scale*0.5]);
            set(gca,'ylim',3*[-W,W]);
            axis off
        end

        xlabel ('x +S\times{u}');

    end

    function Spring_animate
        Scale =6e3;
        W =10;
        SpringX =linspace(0,L,npart);
        SpringY =linspace(0,L,npart);
        SpringY(1:2:end) =W;
        SpringY(2:2:end) =-W;

        ylimit =40*[-W, W];
        l=line(SpringX +0*y(1,1:npart),SpringY);
        axis off
        set(l,'linewidth',1)
        set(l,'color',[0, 0, 0])
        set(gca,'ylim',ylimit);
        set(gca,'xlim',[0,L+Scale*0.5]);
         for i = 1:length(t)
            set(l,'xdata',SpringX +Scale*y(i,1:npart));
            xlabel ('x');ylabel('u');grid on;
            pause(0.1);
        end
        ylabel(''); grid on; hold on
        xlabel ('x +S\times{u}');
    end

end