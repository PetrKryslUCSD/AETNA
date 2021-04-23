function [bracketx,bracketf] = one_dim_min_golden(fun,bracketx,bracketf,xtol,ftol)
% One-dimensional minimization of a function of a single argument.
% 
% function [bracketx,bracketf] = one_dim_min_golden(fun,bracketx,bracketf,xtol,ftol)
% 
% Returns the bracket that bounds the minimum plus the values of the
% function at the bracket endpoints. 
%
% Example 1:
% fun =@(x)sin(x);
% [bracketx,bracketf] =one_dim_min_bracket(fun)
% [bracketx,bracketf] =one_dim_min_golden(fun,bracketx,bracketf,0.00001,0.00)
% Example 2:
% fun =@(x)x^3-x;
% [bracketx,bracketf] =one_dim_min_bracket(fun)
% [bracketx,bracketf] =one_dim_min_golden(fun,bracketx,bracketf,0.00001,0.00)
% Example 3:
% fun =@(x)-x^3+3*x;
% ezplot(fun)
% [bracketx,bracketf] =one_dim_min_bracket(fun)
% x = fminbnd(fun,bracketx(1),bracketx(3)) % Check using the built-in
% [bracketx,bracketf] =one_dim_min_golden(fun,bracketx,bracketf,0.00001,0.00)
% Example 4 (Mexican hat wavelet):
% xtol=1e-9; ftol=0;
% sig=1;
% fun =@(x)-2/(sqrt(3*sig)*pi^(1/4))*(1-x^2/sig^2)*exp(-(x^2/sig^2)/2);
% ezplot(fun)
% [bracketx,bracketf] = one_dim_min_golden(fun,[-4,-1,4],[],xtol,ftol)
% ezplot(@(x)fun(x-0.3))
% [bracketx,bracketf] = one_dim_min_golden(@(x)fun(x-0.3),[-4,-1,4]+0.3,[],xtol,ftol)

% Golden section ratio -1
GS1 =(sqrt(5)+1)/2-1.0;

[~,ix]=sort(bracketx);
xL=bracketx(ix(1));
xI=bracketx(ix(2));
xU=bracketx(ix(3));
if (isempty(bracketf))
    bracketf=[fun(xL),fun(xI),fun(xU)];
else
    bracketf =bracketf(ix);
end
fL=bracketf(1);
fI=bracketf(2);
fU=bracketf(3);

if (fI>=fL)||(fI>=fU)
    error('Input data do not correspond to a bracket');
end

% See if we could start with the correct position for the Golden section
% partitioning  of the interval; otherwise we will make do with the input
% as given.
axI=xL+GS1*(xU-xL);
afI= fun(axI);
if (afI<fL) && (afI<fU)
    xI=axI; fI=afI;
end


xa=xL+(1-GS1)*(xU-xL);
fa= fun(xa);
while true
    if (xa>xI)% the assumption is xL<=xa<=xI<=xxU
        TMP=xa; xa=xI; xI= TMP;
        TMP=fa; fa=fI; fI= TMP;
    end
    if (fa<fI)
        xU=xI; fU=fI; xI=xa; fI=fa;
        xa=xL+(1-GS1)*(xU-xL);
        fa= fun(xa);
    else
        xL=xa; fL=fa; xa=xI; fa=fI;
        xI=xL+GS1*(xU-xL);
        fI= fun(xI);
    end
    %     (xU-xI)/(xa-xL)
    if (abs(xU-xL)<xtol)
        break;
    end
    if (abs(fU-fL)<ftol)
        break;
    end
end
bracketx=[xL,xI,xU];
bracketf=[fL,fI,fU];

end

