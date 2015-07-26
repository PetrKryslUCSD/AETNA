% Visualize the amplification factor along the real axis
% Note: comment out or uncomment an appropriate line depending on which
% integrator you're interested in:

xlow =-3; xhigh= 0;
n=1000;
% Here it is done much more efficiently and succinctly
x = linspace(xlow,xhigh,n);
y =0*x;
dtlambda = x + 1i*y;


% Here comment out or uncomment an appropriate line depending on which
% integrator you're interested in:
% Modified Euler
z = (1 + dtlambda + 0.5*dtlambda.^2);
% % Backward Euler
% z = 1./(1 - dtlambda);
% % Trapezoidal
% z = (1 + dtlambda/2)./abs(1 - dtlambda/2);
% % Forward Euler
% z = (1 + dtlambda);
% % Fourth order explicit Runge-Kutta
% z = (1+ dtlambda.^1/1+  dtlambda.^2/2+ dtlambda.^3/6+ dtlambda.^4/24)
% % Trapezoidal
% z = abs(1 + dtlambda/2)./abs(1 - dtlambda/2);
% Implicit Modified Euler
% z = abs(1./(1 - dtlambda + 0.5*dtlambda.^2));

plot(x,z)
hold on
xlabel ('Re (\Delta{t}\lambda)')
ylabel ('Amplification factor')
