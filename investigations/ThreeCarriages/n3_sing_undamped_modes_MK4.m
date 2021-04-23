% GEP, using gepbinvpwr2()+shift, Three eigenvectors, undamped, singular stiffness. 
[M,C,K,A,k1,k2,k3,c1,c2,c3] = properties_sing_undamped;
v=rand(size(M,1),3);% initial guess of the eigenvector
tol=1e-9; maxiter =4;% tolerance, how many iterations allowed?
sigma = 0.2;% this is the shift
[lambda,v,converged]=gepbinvpwr2(K+sigma*M,M,v,tol,maxiter)
lambda =lambda-sigma % subtract the shift to get the original eigenvalue
