% Linked buildings, Inverse power iteration for the standard problem
[M,K] = lb_prop;
A=M\K;
tol =1e-4; maxiter= 5;
%  starting vector 
v=ones(size(A,1),1)+1e-1*rand(size(A,1),1);


[lambda,v]=invpwr2(A,v,tol,maxiter) 
sqrt(lambda)/(2*pi)
