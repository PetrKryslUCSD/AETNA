% Block power method for nvecs smallest  eigenvalues (in absolute value).
% 
% function [lambda,v,converged]=bpwr2(A,v,tol,maxiter)
%  
% A = square matrix,
% v= initial guess of the eigenvectors (for instance random), nvecs=size(v,2)
% sigma = eigenvalue shift,
% tol= relative tolerance on the eigenvalue,
% maxiter= maximum number of allowed iterations
% Returns
% lambda = computed eigenvalue,
% v= computed eigenvector,
% converged= Boolean flag, converged or not?
% 
% (C) 2008, Petr Krysl
function [lambda,v,converged]=bpwr2(A,v,tol,maxiter)
    [m,n] = size(A);
    if (m ~= n), error('Error: matrix A is not square');
    end
    nvecs =size(v,2);
    plambda=Inf+zeros(nvecs,1);
    lambda =plambda;
    nvecs=size(v,2);% How many eigenvalues?
    [v,r]=qr(v,0);% normalize
    converged = false;% not yet
    for iter=1:maxiter
        u=A*v; % update vectors
        for j=1:nvecs % Rayleigh quotient
            lambda(j)=(u(:,j)'*v(:,j))./(v(:,j)'*v(:,j));
        end
        [v,r]=qr(u,0);% economy QR factorization
        if (norm(lambda-plambda)/norm(lambda)<tol)
            converged = true; break;
        end
        plambda=lambda;
    end
end
