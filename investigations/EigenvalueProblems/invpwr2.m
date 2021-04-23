% Inverse power method for the smallest eigenvalue (in absolute value).
% 
% function [lambda,v,converged]=invpwr2(A,v,tol,maxiter)
%  
% It performs the inverse power iteration for 
% A = square matrix,
% v= initial guess of the eigenvector (for instance random),
% tol= relative tolerance on the eigenvalue,
% maxiter= maximum number of allowed iterations
% Returns
% lambda = computed eigenvalue,
% v= computed eigenvector,
% converged= Boolean flag, converged or not?
% 
% (C) 2008, Petr Krysl
function [lambda,v,converged]=invpwr2(A,v,tol,maxiter)
    [m,n] = size(A);
    if (m ~= n), error('Error: matrix A is not square');
    end
    plambda=Inf;% initialize eigenvalue in previous iteration
    v=v/norm(v);% normalize
    [L,U,p]=lu(A,'vector');%Factorization
    converged = false;% not yet
    for iter=1:maxiter
        u=U\(L\v(p)); % update eigenvector approx, equiv. to u=A\v
        lambda=(v'*v)/(u'*v);% Rayleigh quotient: note the inverse
        v=u/norm(u);% normalize
        if (abs(lambda-plambda)/abs(lambda)<tol)
            converged = true; break;% converged!
        end
        plambda=lambda;
    end
end
