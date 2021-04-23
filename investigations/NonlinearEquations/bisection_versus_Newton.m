% Compare the convergence rate of the bisection and the Newton method.
testbisect_conv_rate
hold on
testnewt_conv_rate
title( [char(f) ', Bisection versus Newton'])



% [solHist] = newt (@(x)((x-1)^2), @(x)(2*(x-1)), 2.0, 1e-9)
% e=abs(solHist-solHist(end))
% loglog(e(1:end-2),e(2:end-1))