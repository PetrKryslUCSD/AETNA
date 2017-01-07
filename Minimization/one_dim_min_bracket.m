function [bracketx,bracketf] = one_dim_min_bracket(fun)
% One-dimensional minimization of a function of a single argument.
% 
% [bracketx,bracketf] = one_dim_min_bracket(fun)
%
% Examples:
% [bracketx,bracketf] = one_dim_min_bracket(@(x)x^2)
%
% fun =@(x)-x^3+3*x;
% [bracketx,bracketf] = one_dim_min_bracket(fun)
%
% sig=1;
% fun =@(x)2/(sqrt(3*sig)*pi^(1/4))*(1-x^2/sig^2)*exp(-(x^2/sig^2)/2);
% [bracketx,bracketf] = one_dim_min_bracket(fun)
% ezplot(fun)

f0=fun(0);

% First we will try to find a point at which the function value is below
% that at the argument 0 (origin).
iteration = 0; maxiteration=300;% let's keep the size of the interval below the largest double
dx=eps;
while true
    fp=fun(dx);
    if (fp<f0)
        f1=f0; x1=0;
        f2=fp; x2=dx;
        break;
    elseif (fp>f0)
        f1=fp; x1=dx;
        f2=f0; x2=0;
        dx =-dx;
        break;
    end
    dx =-dx;
    fp=fun(dx);
    if (fp<f0)
        f1=f0; x1=0;
        f2=fp; x2=dx;
        break;
    elseif (fp>f0)
        f1=fp; x1=dx;
        f2=f0; x2=0;
        dx =-dx;
        break;
    end
    dx=dx*2;
    iteration = iteration+1;
    if (iteration >maxiteration)
        error( ['Initial bracket not found']);
    end
end

% Now we will keep going with the chosen direction dx to find the bracket
iteration = 0; maxiteration=300;% let's keep the size of the interval below the largest double
while true
    dx=dx*2;
    f3=fun(dx);
    if (f2<f3)
        xL=min([x1,dx]); xU=max([x1,dx]); xI=x2;
        fL=fun(xL); fU=fun(xU); fI=fun(xI);
        bracketx=[xL,xI,xU]; bracketf=[fL,fI,fU];
        break;
    elseif (f2<f1)
        f1=f2; x1=x2;
        x2=dx; f2=f3;
    end
    iteration = iteration+1;
    if (iteration >maxiteration)
        error( ['Bracket not found']);
    end
end

end

