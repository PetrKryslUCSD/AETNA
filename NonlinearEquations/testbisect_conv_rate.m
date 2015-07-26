% Test the convergence of the bisection method.

% The function 
f=@(x)(-0.5+(x-1)^3);  
% the initial bracket
xu= 2.6;
xl= 1.6;

e=[];
for i=1:9
    e= [e,(xu-xl)];
    [xl,xu] = bisect(f,xl,xu,Inf,Inf);
end

% plot(e(1:end-2),e(2:end-1),'ro-')
% loglog(e(1:end-2),e(2:end-1),'ro-')
grid on
title( [char(f) ', xl=' num2str(xl) ', xu=' num2str(xu)])
labels('$E_k$','$E_{k+1}$')

semilogy(1:length(e),e,'ro--')
grid on
title( [char(f) ', xl=' num2str(xl) ', xu=' num2str(xu)])
labels('Iteration $k$','$E_{k}$')


% [solHist] = newt (@(x)((x-1)^2), @(x)(2*(x-1)), 2.0, 1e-9)
% e=abs(solHist-solHist(end))
% loglog(e(1:end-2),e(2:end-1))