% Heat conduction problem simulation 
function heatCond1
    nTemps= 30;
    %  Data for concrete
    kappa_concrete=1.81; % W/K/m
    rho_concrete = 2350;% kg/m^3
    cv_concrete =0.22*rho_concrete;% per unit volume
    %     Select the data for this calculation
    kappa=kappa_concrete;    cv=cv_concrete;
    % thickness Of the wall
    L=0.6;% m
    % grid length
    h=L/nTemps;
    % matrices
    C = diag(ones(1,nTemps))*cv*h;
    C(nTemps,nTemps)=cv*h/2;% Capacity matrix
    K = diag(ones(1,nTemps))*2-diag(ones(1,nTemps-1),1)*1-diag(ones(1,nTemps-1),-1)*1;
    K(nTemps,nTemps)=1;
    K = kappa/h*K;% Conductivity matrix
    %  prescribed temperature
    T0 =@(t)( 100);
    function v=rhs(t, y, varargin)% right hand side function
        F=-K*y;
        F(1)= F(1)+kappa/h*T0(t);
        v = C\F;
    end
    % setup integration
    [V,D]=eig(-C\K);
    [ignr,IX]=sort (abs(diag(D)));
    V=V(:,IX); D=D(IX,IX);
    Ds =diag(D);
    dt=2/abs(Ds(end))
    tend= 30;
    nsteps = tend/dt;
    tspan= [0,nsteps*dt];
    y0(1:nTemps)=   zeros(nTemps,1);% initial conditions
    %         heatCond1modes % If desired, uncomment to view the modes 
    % Select integrator
    [t,y]=odefeul(@rhs,tspan,y0,odeset('InitialStep',dt));style ='m^-.';
    %     [t,y]=odemeul(@rhs,tspan,y0,odeset('InitialStep',dt));style ='c<-.';
    %     [t,y]=odemeul2(@rhs,tspan,y0,odeset('InitialStep',dt));style ='r>-.';
    %     [t,y]=odebeul(@rhs,tspan,y0,odeset('InitialStep',dt));style ='rv-.';
    %     [t,y]=odetrap(@rhs,tspan,y0,odeset('InitialStep',dt));style ='ro-';
    %     [t,y]=ode23t(@rhs,tspan,y0,odeset('InitialStep',dt));style ='g-';
    %     [t,y]=ode113(@rhs,tspan,y0,odeset('InitialStep',dt));style ='bh--';
    %     figure;
    %     subplots; hold on
    %     figure;
    %     plot(y(:,1),y(:,2)); hold on% phase plot
    %     plot(t,k/2*y(:,1).*y(:,1)+m/2*y(:,2).*y(:,2), style); hold on% energy plot
    xRange=[0,L];
    yRange= [0,100];
    figure;
    for J = 1:length(t)-1
        plot([0,h:h:(nTemps-1)*h,L],[T0(t(J)),y(J,:)], style);
        set (gca,'xlim', xRange);
        set (gca,'ylim', yRange);
        title (['t=' num2str(t(J))])
        pause((t(J+1)-t(J))/dt*0.01);% energy plot
    end
    J=length(t);
    plot([0,h:h:(nTemps-1)*h,L],[T0(t(J)),y(J,:)], style);
    set (gca,'xlim', xRange);
    set (gca,'ylim', yRange);
    title (['t=' num2str(t(J)) '=tend'])
        
%     heat_conduction_wall_modes
end