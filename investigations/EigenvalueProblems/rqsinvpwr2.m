% Rayleigh-quotient shifted inverse power method for the smallest
% eigenvalue (in absolute value).
% 
% function [lambda,v,converged]=rqsinvpwr2(A,v,sigma,tol,maxiter)
% 
% It performs the shifted inverse power iteration for 
% A = square matrix,
% v= initial guess of the eigenvector (for instance random),
% sigma = eigenvalue shift,
% tol= relative tolerance on the eigenvalue,
% maxiter= maximum number of allowed iterations
% Returns
% lambda = computed eigenvalue,
% v= computed eigenvector,
% converged= Boolean flag, converged or not?
% 
% (C) 2009, Petr Krysl
function [lambda,v,converged]=rqsinvpwr2(A,v,sigma,tol,maxiter)
    [m,n] = size(A);
    if (m ~= n), error('Error: matrix A is not square');
    end
    plambda=Inf;% initialize eigenvalue in previous iteration
    v=v/norm(v);% normalize
    if (isempty(sigma)), sigma=(v'*A*v)/(v'*v); end
    converged = false;% not yet
    for iter=1:maxiter
        u=(A-sigma*eye(n))\v; % update eigenvector approx
        lambda=(u'*A*u)/(u'*u);% Rayleigh quotient
        v=u/norm(u);% normalize
        if (abs(lambda-plambda)/abs(lambda)<tol)
            converged = true; break;% converged!
        end
        sigma =lambda;
        plambda=lambda;
    end
end
