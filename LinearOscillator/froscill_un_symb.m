% Free oscillator, undamped, symbolic solution
function froscill_un_symb
    syms m k c omega_n t x0 v0 'real'
    y0= [x0;v0];
    c_cr=2*m*omega_n;
    c=0.0*c_cr;% no damping
    A = [0, 1; -omega_n^2, -(c/m)];
    [V,D] =eig(A);
    L =simple(inv(V)*A*V);
    eLt =diag(exp(diag(L)*t));
    y1=simple(V*eLt*inv(V))*y0; 
    % We should take the eigenvector that goes with +i*omega_n
    j=1; if (imag(D(1,1))==-omega_n), j=2;end
    Z =[real(V(:,j)),-imag(V(:,j))];
    R = [cos(omega_n*t),-sin(omega_n*t);
        sin(omega_n*t),cos(omega_n*t)];
    y2 =simple(Z*R*inv(Z))*y0;
    simplify(y1-y2)
  
end