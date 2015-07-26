% Rayleigh-quotient (cautiously) shifted inverse power method for the smallest
% eigenvalue (in absolute value).
% 
% function [lambda,v,converged]=crqsinvpwr2(A,v,stol,tol,maxiter)
% 
% The shifting is introduced only after the initial convergence to the
% sought eigenvalue has occurred.  Therefore we call this the cautious
% Rayleigh quotient shifting.
% 
% It performs the shifted inverse power iteration for 
% A = square matrix,
% v= initial guess of the eigenvector (for instance random),
% sigma = eigenvalue shift,
% stol = Relative tolerance on the eigenvalue when the shifting starts,
% tol= relative tolerance on the eigenvalue, tol<stol
% maxiter= maximum number of allowed iterations
% Returns
% lambda = computed eigenvalue,
% v= computed eigenvector,
% converged= Boolean flag, converged or not?
% 
% (C) 2009, Petr Krysl
function [lambda,v,converged]=crqsinvpwr2(A,v,stol,tol,maxiter)
    [m,n] = size(A);
    if (m ~= n), error('Error: matrix A is not square');
    end
    plambda=Inf;% initialize eigenvalue in previous iteration
    v=v/norm(v);% normalize
    sigma=0;%
    converged = false;% not yet
    for iter=1:maxiter
        u=(A-sigma*eye(n))\v; % update eigenvector approx
        lambda=(u'*A*u)/(u'*u);% Rayleigh quotient
        v=u/norm(u);% normalize
        if (abs(lambda-plambda)/abs(lambda)<tol)
            converged = true; break;% converged!
        end
        if (abs(lambda-plambda)/abs(lambda)<stol)% close to converged?
            sigma =lambda;% ... only now start shifting
        end
        plambda=lambda;
    end
end
