% Solution of oscillation ODE; Long-time integration
K=[0,-3;3,0];
w0=[0;8];
tspan =[0,1200];
options=odeset ('InitialStep', 0.099);
[t,sol] = ode45(@(t,w) (K*w), tspan, w0, options);
hold on
plot(t,sol(:,1), 'linewidth', 3, 'color', 'red', 'marker', 'none')
plot(t,sol(:,2), 'linewidth', 3, 'color', 'green', 'marker', 'none')
labels('$t$','$\mathrm{Re}\,y,\mathrm{Im}\,y$');
