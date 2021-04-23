% Vibration frequencies of the *unconnected* buildings system 
tol =1e-4; maxiter= 5;

[M,K] = lb_prop_uc;
v=rand(size(K,1),2);


[lambda,phi]=gepbinvpwr2(K,M,v,tol,maxiter)
sqrt(lambda)/(2*pi)


V =phi;