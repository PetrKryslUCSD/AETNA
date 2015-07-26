% Free oscillator, critical damping, symbolic solution
function froscill_crit_symb
    syms m k c omega_n t x0 v0 'real'
    y0= [x0;v0];
    c_cr=2*m*omega_n;
    c=1.0*c_cr;
    A = [0, 1; -omega_n^2, -(c/m)];
    [V,D] =eig(A);% this gives V with only one column
    % so here we solve for the principal vector
    p2 = (A-D(2,2)*eye(2))\V(:,1);
    M = [V(:,1),p2];
    J =simple(inv(M)*A*M);
    eJt =expm(J*t);
    y=simple(M*eJt*inv(M))*y0; 
    x0= 0; v0=1;% [initial displacement; initial velocity]
    m= 13;    k=  6100; omega_n= sqrt(k/m);
    T_n=(2*pi)/omega_n;
    t=linspace(0, 2*T_n, 200);
    plot(t,eval(vectorize(y(1))),'m-'); hold on
    plot(t,eval(vectorize(y(2))),'r--'); hold on
    grid on
    xlabel('t');ylabel('x,v');
    figure(gcf)

end