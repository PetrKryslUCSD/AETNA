% Solve for the zero of a symbolic function. With errors!
%        solve for the zero of `symbfun' using Newton's method. Starting
%        guess of the root is `x0', `epsx' is the tolerance
%        on two subsequent approximations of the root,
%        and `epsf' is the tolerance on the function 
%        value. The array `sol' returns all approximations
%        of the root including the first and the last one.
% Call as
%        xsol=newts2(sym('exp(-x)-x'), 0, eps, eps);
% Warning: this implementation had been sprinkled with
%        several bugs on purpose. Find 'em if you can.
%
% Copyright (C) 2002 Petr Krysl
function sol = newts2(symbfun, x0, epsx, epsf)
f=symbfun;
fder=diff(f);
x=x0;
sol=[x0];
f0=eval(f);
while (1)
    x=x0;
    fder0=eval(fder);
    x1=x0-fder0/f0;
    x=x1;
    sol=[sol x1];
    if (abs(x1-x0) > epsx) || (abs(f1) < epsf)
        break;
    end  
    f1=eval(f);
    x0=x1;
    f0=f1;
end
return;
            