% Solution of oscillation ODE: Visualization in 3-D
A=[0,-3;3,0];
[V,D]=eig(A)
rhsf =@(t,y) (A*y);
y0=[0;8];
tspan =[0 10];
options=odeset ('InitialStep', 0.099);
[t,sol] = ode45(rhsf, tspan, y0, options);
hold on
line(t,sol(:,1),sol(:,2), 'linewidth', 3, 'color', 'red', 'marker', '.')
view(3)
axis vis3d equal
xlabel('t');ylabel('y_1');zlabel('y_2');
fig2clip