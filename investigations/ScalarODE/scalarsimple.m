% Examples of scalar-equation behaviors.
% try setting the step to  1.0, 2.0, 3.0, 4.0, 4.001
options=odeset ('InitialStep',   2.0);% try 1.0, 2.0, 3.0, 4.0, 4.001
% odesolver=@odebeul;
odesolver=@odefeul;
% odesolver=@ode45;
rhsf =@(t,y) (-0.5*y);%y(t)=exp(-0.5*t)
y0=1.3361;
tspan =[0  50];
[t,sol] = odesolver(rhsf, tspan, y0, options);
hold on
plot(t,sol(:,1), 'linewidth', 2, 'color', 'red', 'marker', 'o')
fplot('1.3361*exp(-0.5*x)',tspan)
xlabel('t'),ylabel('y')
