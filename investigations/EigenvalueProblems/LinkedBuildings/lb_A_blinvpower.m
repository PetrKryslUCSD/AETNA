% Vibration frequencies of the *unconnected* buildings system w/ binvpwr2
tol =1e-4; maxiter= 5;

[M,K] = lb_prop_uc;
v=rand(size(K,1),2);

[lambda,v,converged]=binvpwr2(M\K,v,tol,maxiter)
sqrt(lambda)/(2*pi)
