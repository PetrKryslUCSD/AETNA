% Perform one step  of QR iteration
function A = qrstep(A)
[Q,R]=qr(A);
A = R*Q;