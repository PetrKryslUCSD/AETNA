% GEP, using eig(), undamped, singular stiffness. 
[M,C,K,A,k1,k2,k3,c1,c2,c3] = properties_sing_undamped;
%     matrix2latex(K)
    n =size(M,1);
    [V,D]=eig(K,M) 
  