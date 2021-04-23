% Visualization of solution of a complex first order ODE
A=[0,-0.3;0.3,0];
[V,D]=eig(A)
rhsf =@(t,y) (A*y);
y0=[0;8];
tspan =[0 60];
options=odeset ('InitialStep', 0.099);
[t,sol] = ode45(rhsf, tspan, y0, options);
hold on
line(t,sol(:,1),0*sol(:,2), 'linewidth', 2, 'color', 'red', 'marker', 'none')
line(t,0*sol(:,1),sol(:,2), 'linewidth', 2, 'color', 'blue', 'marker', 'none')
line(0*t,sol(:,1),sol(:,2), 'linewidth', 2, 'color', 'black', 'marker', 'none')
streamplot(t, [t,sol], 0.5)
view(3)
grid on
axis vis3d equal
labels('$t$','$\mathrm{Re}\;y$','$\mathrm{Im}\;y$');
fig2clip