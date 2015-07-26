% One step of the QR iteration with shifting (lower right diagonal element).
function A = qrstepS(A)
    [m,n]=size(A);
    rho = A(n,n);
    [Q,R]=qr(A-rho*eye(n,n));
    A = R*Q + rho*eye(n,n);
end
