% Test the convergence rate of the Newton solver 

% Function and its derivative
f=@(x)(-0.5+(x-1)^3);  fd =@(x)(3*(x-1)^2);
% Initial guess
x0 = 2.6;
% Solution
[solHist] = newt (f, fd, x0, 1e-15)
e=abs(solHist-solHist(end))
% plot(e(1:end-2),e(2:end-1),'ro-')
% loglog(e(1:end-2),e(2:end-1),'ro-')
grid on
title( [char(f) ', x0=' num2str(x0)])
labels('$E_k$','$E_{k+1}$')

semilogy(1:length(e),e,'ro-')
grid on
title( [char(f) ', Newton'])
labels('Iteration $k$','$E_{k}$')


% [solHist] = newt (@(x)((x-1)^2), @(x)(2*(x-1)), 2.0, 1e-9)
% e=abs(solHist-solHist(end))
% loglog(e(1:end-2),e(2:end-1))