% Direct numerical integration, non-proportionally damped, singular stiffness.
function n3_damped_sing_non_proportional
    scale = 50;
    scalev = 5;
    [M,C,K,A,k1,k2,k3,c1,c2,c3] = properties_damped_sing_non_proportional;
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
    
abs(diag(D))
   
    tspan = [0, 5];
    dt =2*pi/max(abs(diag(D)))/10
%     dt =2*pi/max(abs(diag(D(1:2,1:2))))/10
    mode =2;
    y0 =[0, 0, 0, 1, 1, 1]';
    y0 =real(V(:,mode));
%     y0 =real(V(:,6));
    [t,y]=odetrap(@(t,y)A*y,tspan,y0,odeset('InitialStep',dt));style ='r-';
    figure
%     subplots
    plot(t,y(:,1),'r'); ylabel('y(1)'); grid on; hold on
    plot(t,y(:,2),'g'); ylabel('y(1)'); grid on; hold on
    plot(t,y(:,3),'b'); xlabel('t'); ylabel('y(1:3)'); grid on; hold on
   fig2eps(['n3_oscillator_damped_non_sing_Direct_mode' num2str(mode) '.eps'])

    function subplots
        %         ylim =[min(min(y(:,1:3))),max(max(y(:,1:3)))]
        subplot(3,2,1)
        plot(t,y(:,1),style); ylabel('y(1)'); grid on; hold on
        set(gca,'ylim',ylim);
        subplot(3,2,3)
        plot(t,y(:,2),style); ylabel('y(2)');grid on; hold on
        set(gca,'ylim',ylim);
        subplot(3,2,5)
        plot(t,y(:,3),style); ylabel('y(3)'); grid on; hold on
        set(gca,'ylim',ylim);
        xlabel ('t');
%         ylim =[min(min(y(:,4:6))),max(max(y(:,4:6)))]
        subplot(3,2,2)
        plot(t,y(:,4),style); ylabel('y(4)'); grid on; hold on
        set(gca,'ylim',ylim);
        subplot(3,2,4)
        plot(t,y(:,5),style); ylabel('y(5)'); grid on; hold on
        set(gca,'ylim',ylim);
        subplot(3,2,6)
        plot(t,y(:,6),style); ylabel('y(6)'); grid on; hold on
        set(gca,'ylim',ylim);
        xlabel ('t');
    end
end