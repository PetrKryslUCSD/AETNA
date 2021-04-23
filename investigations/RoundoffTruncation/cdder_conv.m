% A simple function to test round of an truncation interplay.
% 
% function [dxs,ers]=cdder_conv(funhand, funderhand, x, n, dx0,
% divFactor)
% 
% funhand = function handle, function returning the value, 
% funderhand =function handle, function returning the Exact derivative, 
% x = location where the derivatives the computed, 
% n =  number of approximations to compute,
% dx0 = initial step to use in the forward Euler formula,
% divFactor = factor by  which to divide the initial step in each new
%                 approximation
% Example: 
% 
% funhand=@(x)exp(x)*cos(x);
% funderhand=@(x)exp(x)*cos(x)+exp(x)*(-sin(x));
% x=85;
% n= 6;
% dx0= 0.3;
% divFactor=4;
% 
% [dxs,ers]=cdder_conv(funhand, funderhand, x, n, dx0, divFactor);
% loglog (dxs,ers,'ro-');xlabel ('dx');ylabel ('err'); hold on
% 
function [dxs,ers]=cdder_conv(funhand, funderhand, x, n, dx0, divFactor)
    dxs=[]; ers=[];
    dx=dx0;
    for i=1:n
        fdiff =funhand(x+dx) - funhand(x-dx); 
        dfapp = (fdiff)/((2*dx)) ;
        dfex  = funderhand(x);
        disp( [dx,fdiff,dfapp-dfex])
        dxs=[dxs dx]; ers=[ers abs(dfex-dfapp)/abs(dfex)];
        dx=dx/divFactor;
    end
    return;
end
