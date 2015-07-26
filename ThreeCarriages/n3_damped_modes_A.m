% Standard eigenvalue problem, numerical, proportionally damped. 
[M,C,K,A] = properties_damped_proportional;
nparticles =size(M,1);
[V,D]=eig(A);

[Ignore,ix] = sort(abs(diag(D)));
D =D(ix,ix);
V=V(:,ix);