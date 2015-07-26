% Solve solve for the zero of a symbolic function with the Newton method
%
% function sol = newt_symb(symbfun, x0, epsx, epsf, maxiter)
% 
%        Starting guess of the root is `x0', `epsx' is the tolerance
%        on two subsequent approximations of the root,
%        and `epsf' is the tolerance on the function 
%        value. The array `sol' returns all approximations
%        of the root including the first and the last one.
%        maxiter is the maximum number of allowed iterations.  
% Example
%        xsol=newt_symb(sym('exp(-x)-x'), 0, eps, eps, maxiter);
%
% Copyright (C) 2002,2011 Petr Krysl
function sol = newt_symb(symbfun, x0, epsx, epsf, maxiter)
    f=symbfun;
    fder=diff(f);
    x=x0;
    sol=[x0];
    f0=eval(f);
    iter=1;
    while (iter<maxiter)
        x=x0;
        fder0=eval(fder);
        x1=x0-f0/fder0;
        x=x1;
        f1=eval(f);
        sol=[sol x1];
        if (abs(x1-x0) < epsx) && (abs(f1) < epsf)
            break;
        end
        x0=x1;
        f0=f1;
        iter=iter+1;
    end
end
