% Test inverse power iteration convergence
n=13;
tol =1e-64; maxiter= 24;
v=rand(n,1);% starting vector
[Q,R]=qr(rand(n));
D =(13:25);
for D1 = [13,6.1]
    D(1) =D1;
    A=Q'*diag(D)*Q;
    lambda1= [];
    for iter =1:maxiter
        [lambda,phi, converged]=invpwr2(A,v,tol,iter);
        lambda1 = [lambda1,lambda];
    end
    semilogy((lambda1-D1)/D1,'r-x');
    
    grid on
    hold on

end

labels(' Iteration',' Relative eigenvalue error')
