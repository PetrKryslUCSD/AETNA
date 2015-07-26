% Test power iteration
A = diag(2*ones(4,1))+diag(-1*ones(3,1),1)+diag(-1*ones(3,1),-1)
[V,D] =eig(A);
diag(D)'
V(:,1)
tol =1e-4; maxiter= 24;
v=rand(size(A,1),1);
[lambda,phi,converged]=pwr2(A,v,tol,maxiter)
