% Standard eigenvalue problem, numerical, undamped. 

[M,C,K,A] = properties_undamped;
nparticles =size(M,1);
[V,D]=eig(A);

[Ignore,ix] = sort(abs(diag(D)));
D =D(ix,ix);
V=V(:,ix);