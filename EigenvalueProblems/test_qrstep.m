% Test QR iteration step

A = diag(2*ones(4,1))+diag(-1*ones(3,1),1)+diag(-1*ones(3,1),-1)
[V,D] =eig(A)

A = qrstep(A)
% schur(A)