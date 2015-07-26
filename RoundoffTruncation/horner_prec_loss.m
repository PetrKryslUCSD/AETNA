% Horner's scheme may lose precision due to finite-precision arithmetic. 
% Show how Horner's scheme may lose precision due to finite-precision
% arithmetic (Neumaier 2001).
function horner_prec_loss
x=(9950:10050)/10000;
y=(1-x).^6;
z=1+(-6+(15+(-20+(15+(-6+x).*x).*x).*x).*x).*x;
plot(x,1e15*y);
hold on;
plot(x,1e15*z,'red');
