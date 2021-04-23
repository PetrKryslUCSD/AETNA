% Visualize the amplification factor along the imaginary axis
% Note: comment out or uncomment an appropriate line depending on which
% integrator you're interested in:

ylow =-6.2; yhigh= 6.2;
n=1000;
% Here it is done much more efficiently and succinctly
y = linspace(ylow,yhigh,n);
x =0*y;
dtlambda = x + 1i*y;


% Here comment out or uncomment an appropriate line depending on which
% integrator you're interested in:
% Modified Euler
z = abs(1 + dtlambda + 0.5*dtlambda.^2);
% % Backward Euler
% z = 1./abs(1 - dtlambda);
% % Trapezoidal
% z = abs(1 + dtlambda/2)./abs(1 - dtlambda/2);
% % Forward Euler
% z = abs(1 + dtlambda);
% % Fourth order explicit Runge-Kutta
% z = abs(1+ dtlambda.^1/1+ ...
%      dtlambda.^2/2+ dtlambda.^3/6+ dtlambda.^4/24)
% % Trapezoidal
% z = abs(1 + dtlambda/2)./abs(1 - dtlambda/2);
% Implicit Modified Euler
% z = abs(1./(1 - dtlambda + 0.5*dtlambda.^2));

plot(y,z)
hold on
xlabel ('Im (\Delta{t}\lambda)')
ylabel ('Amplification factor')
