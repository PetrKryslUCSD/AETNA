% Visualization of solution of a complex first order ODE; standard plots
A=[0,-0.3;0.3,0];
[V,D]=eig(A)
rhsf =@(t,y) (A*y);
y0=[0;8];
tspan =[0 60];
options=odeset ('InitialStep', 0.099);
[t,sol] = ode45(rhsf, tspan, y0, options);
hold on
plot(t,sol(:,1), 'linewidth', 3, 'color', 'red', 'marker', 'none')
plot(t,sol(:,2), 'linewidth', 3, 'color', 'blue', 'marker', 'none')
labels('$t$','$\mathrm{Re}\,y,\mathrm{Im}\,y$');
% title(['\Delta t=' num2str(options.InitialStep)])
fig2clip