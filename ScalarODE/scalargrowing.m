% examples of scalar-equation behaviors
options=odeset ('InitialStep',   4.001);
options=odeset ('InitialStep',   3.999);
options=odeset ('InitialStep',   5);
% options=odeset ('RelTol', 1e-16);
odesolver=@odebeul;
% odesolver=@odefeul;
% odesolver=@ode45;
rhsf =@(t,y) (0.5*y);%y(t)=exp(0.5*t)
y0=1;
tspan =[0   20];
[t,sol] = odesolver(rhsf, tspan, y0, options);
hold on
plot(t,sol(:,1), 'linewidth', 2, 'color', 'blue', 'marker', 'o')
fplot('exp(0.5*x)',tspan)