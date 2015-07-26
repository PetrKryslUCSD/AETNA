% Generalized eigenvalue problem, numerical, undamped. 

[M,C,K,A] = properties_undamped;
nparticles =size(M,1);
[V,D]=eig(K,M);

