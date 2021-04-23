% Generalized eigenvalue problem, undamped, singular stiffness. 

[M,C,K,A,k1,k2,k3,c1,c2,c3] = properties_sing_undamped;
%     matrix2latex(K)
    n =size(M,1);
    [V,D]=eig(K,M);
    v=rand(n,1);
    tol=1e-6; maxiter =1;
    [lambda,v,converged]=gepbinvpwr2(K,M,v,tol,maxiter)