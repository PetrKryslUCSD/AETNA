% Direct time integration of the response of the linked buildings
function lb_direct
    [M,K] = lb_prop;
    n=size(M,1);
    L =zeros(n,1);
    L(1) = 1;
    function v=rhs(t, y, varargin)
        v = [y(n+1:end); M\(-K*y(1:n)+L)];
    end
    [V,D]=eig(K,M);
    max_omega=sqrt(max(diag(D)))
    min_omega=sqrt(min(diag(D)))
    dt= (2*pi/sqrt(mean(diag(D))))/10;
    nsteps = 500;%5*(2*pi/min_omega)/dt;
    tspan= [0,nsteps*dt];
    y0=zeros(2*n,1);% [initial displacement; initial velocity]
%         [t,y]=odefeul(@rhs,tspan,y0,odeset('InitialStep',dt));style ='m^-.';
%         [t,y]=odemeul(@rhs,tspan,y0,odeset('InitialStep',dt));style ='c<-.';
    %     [t,y]=odemeul2(@rhs,tspan,y0,odeset('InitialStep',dt));style ='r>-.';
    %     [t,y]=odebeul(@rhs,tspan,y0,odeset('InitialStep',dt));style ='rv-.';
    [t,y]=odetrap(@rhs,tspan,y0,odeset('InitialStep',dt));style ='r-';
%     [t,y]=odeimeul(@rhs,tspan,y0,odeset('InitialStep',dt));style ='k-';
%         [t,y]=ode23t(@rhs,tspan,y0,odeset('InitialStep',dt));style ='g-';
%         [t,y]=ode113(@rhs,tspan,y0,odeset('InitialStep',dt));style ='bh--';
%     figure; 
%     subplots; hold on
    figure;
%     animate;
    %     plot(y(:,1),y(:,2)); hold on% phase plot
    %     plot(t,k/2*y(:,1).*y(:,1)+m/2*y(:,2).*y(:,2), style); hold on% energy plot
    subplots

    function subplots
        subplot(3,2,1)
        plot(t,y(:,1),style); ylabel('y(1)'); grid on; hold on
        subplot(3,2,3)
        plot(t,y(:,2),style); ylabel('y(2)');grid on; hold on
        subplot(3,2,5)
        plot(t,y(:,3),style); ylabel('y(3)'); grid on; hold on
        subplot(3,2,2)
        plot(t,y(:,4),style); ylabel('y(4)'); grid on; hold on
        subplot(3,2,4)
        plot(t,y(:,5),style); ylabel('y(5)'); grid on; hold on
        subplot(3,2,6)
        plot(t,y(:,6),style); ylabel('y(6)'); grid on; hold on
    end

    function subplots_y13
        subplot(4,2,4)
        plot(t,y(:,1),'r-'); ylabel('y(1)'); grid on; hold on
        subplot(4,2,6)
        plot(t,y(:,2),'b-'); ylabel('y(2)');grid on; hold on
        subplot(4,2,8)
        plot(t,y(:,3),'g-'); ylabel('y(3)'); grid on; hold on
    end

    function animate
        subplots_y13
        subplot(4,2, [1, 3, 5, 7])
        L = 0.03;
        particles = [
            struct('index', [1],'location',-L,'marker', line(0, 0,'color','red','marker','o', ...
            'markersize',20,'linestyle','-','linewidth',7,...
            'erasemode','background')),
            struct('index', [2],'location',-2*L,'marker', line(0, 0,'color','blue','marker','o', ...
            'markersize',20,'linestyle','-','linewidth',7,...
            'erasemode','background')),
            struct('index', [3],'location',-3*L,'marker', line(0, 0,'color','green','marker','o', ...
            'markersize',20,'linestyle','-','linewidth',7,...
            'erasemode','background'))];
        springs = [
            struct('indexes', [0,1],'line', line(0, L,'color','black','marker','.', ...
            'markersize',10,'linestyle',':','linewidth',6,...
            'erasemode','background')),
            struct('indexes', [1,2],'line', line(0, L,'color','black','marker','.', ...
            'markersize',10,'linestyle',':','linewidth',6,...
            'erasemode','background')),
            struct('indexes', [2,3],'line', line(0, L,'color','black','marker','.', ...
            'markersize',10,'linestyle',':','linewidth',6,...
            'erasemode','background'))];

        maxW =max([abs(min(y(:, 1))),abs(max(y(:, 1)))]);
        maxW =max([maxW,abs(min(y(:,2))),abs(max(y(:,2)))]);
        maxW =max([maxW,abs(min(y(:,3))),abs(max(y(:,3)))]);
        axis([-0.1*maxW 0.1*maxW -3.1*L-1.5*maxW 0.1*L+1.5*maxW]);
%         axis square
        hold on
        figure(gcf)
        npause =round(max( [1,length(y(:,1))/500]));
        for j = 1:length(t)-1
            for p =1:length(springs)
                ydata = [0, 0];
                for q= 1:2,
                    if springs(p).indexes(q)~=0
                        ydata(q) =particles(springs(p).indexes(q)).location-y(j,springs(p).indexes(q));
                    end
                end
                set(springs(p).line,'xdata',[0,0],'ydata',ydata);
            end
            for p =1:length(particles)
                set(particles(p).marker,'xdata',0,'ydata',particles(p).location-y(j,particles(p).index));
            end
            
            pause(0.0003);
        end
    end

end