% Newton's method implementation.
%
% function [solHist] = newt (fun, funder, x0, xtol)
% 
% fun = function handle, 
% funder= function handle, the derivative of the function, 
% x0= initial guess of the root location, 
% xtol= root location tolerance
function [solHist] = newt (fun, funder, x0, xtol)
    solHist = [ ];
    x = x0;
    solHist = [ solHist x ];
    while (1)
        xprev = x;
        x = x - feval (fun, x) / feval (funder, x);
        solHist = [ solHist x ];
        if (abs(x - xprev) < xtol)
            break;
        end;
    end
end
