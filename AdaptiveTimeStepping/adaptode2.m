% Adaptive time integration 
options=odeset ('InitialStep',   0.095, 'AbsTol', 1e-2,'reltol',2*eps,'refine',1);
% Select the solver that you want by uncommenting a line:
odesolver=@odefeul; Color ='blue'; Marker ='s';
odesolver=@odefeuladapt; Color ='blue'; Marker ='v';
% odesolver=@oderk4adapt; Color ='black'; Marker ='x'; 
odesolver=@ode45; Color ='magenta'; Marker ='o';
% odesolver=@ode23; Color ='cyan'; Marker ='o';
rhsf =@(t,y) ([-20,1;1,-2]*y+exp(sin(t)));
y0=[1,-1]';
tspan =[0  14];
[t,sol] = odesolver(rhsf, tspan, y0, options);
figure
hold on
plot(t,sol(:,1), 'linewidth', 2, 'color', Color)
plot(t,sol(:,2), 'linewidth', 2, 'color', Color,'linestyle','--')
hold off
labels('Time','Solution components')
figure
plot(t(1:end-1),diff(t), 'linewidth', 2, 'color', Color, 'marker', Marker)
labels('Time','Time step')
