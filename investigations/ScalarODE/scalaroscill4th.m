% Solution of oscillation ODE: forward Euler
A=[-0.1,-3;3,-0.1];
[V,D]=eig(A)
rhsf =@(t,y) (A*y);
y0=[0;8];
tspan =[0 10];
dt=0.01;
abs(1+dt*D(1,1))
options=odeset ('InitialStep', dt,'RelTol',1e-16,'AbsTol',1e-16);
[t,sol] = odefeul(rhsf, tspan, y0, options);
hold on
plot(t,sol(:,1), 'linewidth', 3, 'color', 'red', 'marker', 'o')
plot(t,sol(:,2), 'linewidth', 3, 'color', 'green', 'marker', 'x')
xlabel('t');ylabel('y');
title(['\Delta t=' num2str(options.InitialStep)])
fig2clip