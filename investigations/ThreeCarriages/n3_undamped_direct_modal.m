% Integration of the normal coordinates, undamped.
function n3_undamped_direct_modal
    scale = 50;
    scalev = 5;
    [M,C,K,A,k1,k2,k3,c1,c2,c3] = properties_undamped;
    nparticles =size(M,1);
    %     [V,D]=eig(K,M);
    % [V,D]=eig(M^-1*K);
    [V,D]=eig(A);
    [Ignore,ix] = sort(abs(diag(D)));
    D =D(ix,ix);
    V=V(:,ix);
    %     ReV =real(V); ReV(find(abs(real(V))<1e-9)) =0;
    %     ImV =imag(V); ImV(find(abs(imag(V))<1e-9))=0;
    %     matrix2latex(ReV+i*ImV,2)
    %     matrix2latex(D,2)
    %     Gray =[0.72, 0.72, 0.72];
    
    (diag(D))
    
    tspan = [0, 5];
    mode =2;
    y0 =real(V(:,mode));
    w0 =V\y0;
    figure
    for j=2 % select which mode should be integrated
        lambda =D(j,j);
        F=@(dt)(abs(1+(dt*lambda)+(dt*lambda)^2/2+(dt*lambda)^3/6+(dt*lambda)^4/24)-1);
        dt =fzero(F, 1.0) % this will give constant amplitude
        [t,w]=oderk4(@(t,w)lambda*w,[0,100*dt],w0(j),odeset('InitialStep',dt));
        plot(t,abs(w),'rx'); hold on
        % this will give diminishing amplitude
        [t,w]=oderk4(@(t,w)lambda*w,[0,100*dt],w0(j),odeset('InitialStep',dt/10));
        plot(t,abs(w),'k'); hold on
        % this will give growing amplitude
        [t,w]=oderk4(@(t,w)lambda*w,[0,100*1.00001*dt],w0(j),odeset('InitialStep',1.00001*dt));
        plot(t,abs(w),'b'); hold on
   end
    ylabel('|w|'); grid on;
    xlabel('t');
    
    
end