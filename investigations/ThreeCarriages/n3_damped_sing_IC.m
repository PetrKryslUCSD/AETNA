% Motion due to IC, singular stiffness. 
function n3_damped_sing_IC
    [M,C,K,A] = properties_damped_sing_non_proportional;
    nparticles =size(M,1);
    [V,D]=eig(A);
    [Ignore,ix] = sort(abs(diag(D)));
    D =D(ix,ix);
    V=V(:,ix);
    abs(diag(D))

    tspan = [0, 5];
    dt =2*pi/max(abs(diag(D)))/10
    mode = 6;
    y0 =real(V(:,mode));
    [t,y]=odetrap(@(t,y)A*y,tspan,y0,odeset('InitialStep',dt));style ='r-';
    figure
    plot(t,y(:,1),'r'); ylabel('y(1)'); grid on; hold on
    plot(t,y(:,2),'g'); ylabel('y(1)'); grid on; hold on
    plot(t,y(:,3),'b'); xlabel('t'); ylabel('y(1:3)'); grid on; hold on

end