% Stable integration with RK4, undamped. 
function n3_undamped_stable_rk4
  
    [M,C,K,A,k1,k2,k3,c1,c2,c3] = properties_undamped;
    nparticles =size(M,1);

    [V,D]=eig(A);
    [Ignore,ix] = sort(abs(diag(D)));
    D =D(ix,ix);
    V=V(:,ix);

    (diag(D))

    dts=[];
    for j=1:size(A,1)
        lambda =D(j,j);
        F=@(dt)(abs(1+(dt*lambda)+(dt*lambda)^2/2+(dt*lambda)^3/6+(dt*lambda)^4/24)-1);
        dts(end+1) =fzero(F,2.8/abs(lambda));
    end
   dts

%     dt =1.002*min(dts); % Growing solution
%    tspan = [0, 200*dt];
    dt =1.00*min(dts);% non-growing solution
    tspan = [0, 400*dt];
   
    y0 =real(V(:,2))+real(V(:,4))+real(V(:,6));
    %     y0 =real(V(:,6));
    [t,y]=oderk4(@(t,y)A*y,tspan,y0,odeset('InitialStep',dt));style ='r-';
   
    plot(t,y(:,1),'r'); ylabel('y(1)'); grid on; hold on
    plot(t,y(:,2),'g'); ylabel('y(1)'); grid on; hold on
    plot(t,y(:,3),'b'); xlabel('t'); ylabel('y(1:3)'); grid on; hold on
    axis tight
end