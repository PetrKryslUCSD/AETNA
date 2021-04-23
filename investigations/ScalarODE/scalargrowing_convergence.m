% examples of scalar-equation behaviors
rhsf =@(t,y) (6*y);
y0=1;
tspan =[0  4];
dts = 2.^(-(3:10));

odesolver=@odebeul;
sols = [];
for dt =dts
    options=odeset ('InitialStep', dt);
    [t,sol] = odesolver(rhsf, tspan, y0, options);
%     figure; plot(t,sol); pause
    sols =[sols,sol(end)];
end
bsols =sols;

odesolver=@odefeul;
sols = [];
for dt =dts
    options=odeset ('InitialStep', dt);
    [t,sol] = odesolver(rhsf, tspan, y0, options);
    sols =[sols,sol(end)];
end
fsols =sols;

odesolver=@odemeul;
sols = [];
for dt =dts
    options=odeset ('InitialStep', dt);
    [t,sol] = odesolver(rhsf, tspan, y0, options);
    sols =[sols,sol(end)];
end
msols =sols;

figure
hold on
plot(dts,fsols, 'linewidth', 2, 'color', 'blue', 'marker', 'o')
plot(dts,bsols, 'linewidth', 2, 'color', 'red', 'marker', 'o')
plot(dts,msols, 'linewidth', 2, 'color', 'k', 'marker', 'o')

ea_f =diff(fsols)
ea_b =diff(bsols)
ea_m =diff(msols)
hold on
plot(dts(2:end),abs(ea_f), 'linewidth', 2, 'color', 'blue', 'marker', 'o')
plot(dts(2:end),abs(ea_b), 'linewidth', 2, 'color', 'red', 'marker', 'o')
plot(dts(2:end),abs(ea_m), 'linewidth', 2, 'color', 'k', 'marker', 'o')


figure;

loglog(dts(2:end),abs(ea_f), 'linewidth', 2, 'color', 'blue', 'marker', 'o');hold on
loglog(dts(2:end),abs(ea_b), 'linewidth', 2, 'color', 'red', 'marker', 'o');hold on
loglog(dts(2:end),abs(ea_m), 'linewidth', 2, 'color', 'k', 'marker', 'o');hold on