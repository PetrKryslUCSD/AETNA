% Power method for the largest eigenvalue (in absolute value).
% 
% function [lambda,v,converged]=pwr2(A,v,tol,maxiter)
%  
% It performs the power iteration for 
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
function [lambda,v,converged]=pwr2(A,v,tol,maxiter)
    [m,n] = size(A);
    if (m ~= n), error('Error: matrix A is not square');
    end
    plambda=Inf;% eigenvalue in previous iteration
    converged = false;
    for iter=1:maxiter
        u=A*v; % update eigenvector approx
        lambda=(u'*v)/(v'*v);% Rayleigh quotient
        v=u/norm(u);% normalize
        if (abs(lambda-plambda)/abs(lambda)<tol)
            converged = true; break;% converged!
        end
        plambda=lambda;% eigenvalue in previous iteration
    end
end
