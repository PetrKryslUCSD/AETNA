% Free oscillator, supercritical damping, symbolic solution
function froscill_super_symb
    syms m k c omega_n t x0 v0 'real'
    y0= [x0;v0];
    c_cr=2*m*omega_n;
    c=3/2*c_cr;
    A = [0, 1; -omega_n^2, -(c/m)];
    [V,D] =eig(A);
    L =simple(inv(V)*A*V);
    eLt =diag(exp(diag(L)*t));
    y=simple(V*eLt*inv(V))*y0; 
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