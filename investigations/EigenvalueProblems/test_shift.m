% Test shifting in inverse power iteration
A =[  2.486697669648270  -0.326429831194336  -1.065046141649933
  -0.326429831194336   2.167809045836811   1.032918306492685
  -1.065046141649933   1.032918306492685   2.345493284514918];
n=3;
[V,D]=eig(A)
tol =1e-6; maxiter= 24;
v=rand(n,1);% starting vector
sigma =1.6;% the shift
[lambda,phi,converged]=sinvpwr2(A,v,sigma,tol,maxiter)
