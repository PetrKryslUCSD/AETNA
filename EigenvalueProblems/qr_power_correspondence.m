% Show the equivalence of the iterated matrices from block power and QR iteration

% First we are going to create the test matrix
n = 4;
A = rand(n); 
A0=(A+A')/2;

maxiter =5;% The maximum number of iterations to do

% Perform maxiter steps of Power iteration
A=A0;
W=eye(size(A));
for it = 1:maxiter
    Wb=A*W;
    [W,R] = qr(Wb);
end
Ak=W'*A*W
W

A=A0; 
W=eye(size(A));
for it = 1:maxiter
    [Q,R] = qr(A);
    A=R*Q;
    W=W*Q;
end
A
W






