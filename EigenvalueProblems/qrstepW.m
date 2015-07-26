% One step of the QR iteration with Wilkinson shifting
function A = qrstepW(A)
    [m,n]=size(A);
    lambda = eig(A(n-1:n,n-1:n));
    [m,i] = min( abs(lambda-A(n,n)) );
    rho = lambda(i(1));
    disp(['rho = ' num2str(rho)])
    [Q,R]=qr(A-rho*eye(n,n));
    A = R*Q + rho*eye(n,n);
end