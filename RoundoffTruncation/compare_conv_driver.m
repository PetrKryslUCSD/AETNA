%  Test numerical derivative for Euler and centered difference methods. 

% The present script tests convergence of the numerical approximation of
% derivatives for the forward and backward Euler method and a centered
% difference method.
% 
%  There are several sets of function/evaluation point; Choose the one you
%  want and comment out or uncomment the corresponding block


% Set 1
% funhand=@(x)exp(x)*cos(x);
% funderhand=@(x)exp(x)*cos(x)+exp(x)*(-sin(x));
% x=pi;
% n= 16;
% dx0= 0.3;
% divFactor=4;

% Set 2
% funhand=@(x)2*x^2-1/3*x^3;
% funderhand=@(x)4*x-3/3*x^2;
% x=pi;
% n= 9;
% dx0= 0.3;
% divFactor=4;

% % Set 3
funhand=@(x)x^3*exp(-x);
funderhand=@(x)3*x^2*exp(-x)-x^3*exp(-x);
x=pi;
n= 19;
dx0= 0.3;
divFactor=4;

% % Set 4
% funhand=@(x)exp(x);
% funderhand=@(x)exp(x);
% x=pi;
% n= 30;
% dx0= 0.3;
% divFactor=4;
 
% Set 5
funhand=@(x)x^3*exp(-x);
funderhand=@(x)3*x^2*exp(-x)-x^3*exp(-x);
x=22*pi;
n= 19;
dx0= 0.3;
divFactor=4;

% Set 6
funhand=@(x)2*x^2-1/3*x^3;
funderhand=@(x)4*x-3/3*x^2;
x=1e1;
n= 9;
dx0= 0.3;
divFactor=4;

% Set 7
% funhand=@(x)cos(pi*x);
% funderhand=@(x)-pi*sin(pi*x);
% x=1.333e9;
% n= 7;
% dx0= 0.03;
% divFactor=10;

[dxs,ers]=feulder_conv(funhand, funderhand, x, n, dx0, divFactor);
loglog (dxs,ers,'ro-');xlabel ('dx');ylabel ('err'); hold on

[dxs,ers]=beulder_conv(funhand, funderhand, x, n, dx0, divFactor);
loglog (dxs,ers,'gd-');xlabel ('dx');ylabel ('err'); hold on

[dxs,ers]=cdder_conv(funhand, funderhand, x, n, dx0, divFactor);
loglog (dxs,ers,'bs-');xlabel ('dx');ylabel ('err'); hold on

grid on
figure(gcf)

% legend( {'double','single'},'location','northwest')
