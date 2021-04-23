% Implementation of the bisection method.
%
% function [xl,xu] = bisect(funhandle,xl,xu,tolx,tolf)
% 
% Tolerance both on x and on f(x).
% funhandle = function handle,
% xl= lower value of the bracket,
% xu= upper Value of the bracket,
% tolx= tolerance on the location of the root,
% tolf= tolerance on the function value
function [xl,xu,iter] = bisect(funhandle,xl,xu,tolx,tolf)
    iter=0;
    if (xl >xu)
        temp =xl; xl = xu; xu =temp;
    end
    fl=feval(funhandle,xl);
    fu=feval(funhandle,xu);
    if fl*fu > 0
        error('Need to get a bracket');
    end
    if fl == 0
        xu=xl;
        return;
    end
    if fu == 0
        xl=xu;
        return;
    end
    while 1
        xr=(xu+xl)/2; % bisect interval
        fr=feval(funhandle,xr); % value at the midpoint
        if (fr*fl < 0),   xu=xr; fu=fr;% upper --> midpoint
        elseif (fr == 0), xl=xr; xu=xr;% exactly at the root
        else,             xl=xr; fl=fr;% lower --> midpoint
        end
        if (abs(xu-xl) < tolx) || (abs(fr) < tolf)
            break; % We are done
        end
        iter=iter+1;
    end
end