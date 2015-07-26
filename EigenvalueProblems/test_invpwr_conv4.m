% Test Raleyigh-quotient shifted inverse power iteration; cautious shifting
% variant
n=13;
tol =1e-64; maxiter= 24; stol = 0.001;
v=rand(n,1);% starting vector
[Q,R]=qr(rand(n));
D =(13:25);
for D1 = [13]
    D(1) =D1;
    A=Q'*diag(D)*Q;
    lambda1= [];
    for iter =1:maxiter
        [lambda,phi]=crqsinvpwr2(A,v,stol,tol,iter)
        lambda1 = [lambda1,lambda];
    end
    semilogy((lambda1-D1)/D1,'r-x');

    grid on
    hold on

end

labels(' Iteration',' Relative eigenvalue error')
