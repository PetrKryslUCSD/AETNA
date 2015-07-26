% Convergence of solutions to a scalar equation. W/ oderk4
rhsf =@(t,y) (-0.5*y);
y0=1;
tspan =[0  4];
dts = [2, 1, 1/2, 1/4, 1/8, 1/16, 1/32];
dts = [2, 1, 1/2, 1/4, 1/8, 1/16, 1/32 1/64 1/128];
dts = [2, 1, 1/2, 1/4, 1/8, 1/16, 1/32 1/64 1/128 1/256 1/512 ];

odesolver=@oderk4;
sols = [];
for dt =dts
    options=odeset ('InitialStep', dt);
    [t,sol] = odesolver(rhsf, tspan, y0, options);
    sols =[sols,sol(end)];
end
rsols =sols;

odesolver=@odebeul;
sols = [];
for dt =dts
    options=odeset ('InitialStep', dt);
    [t,sol] = odesolver(rhsf, tspan, y0, options);
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

figure;
hold on
plot(dts,fsols, 'linewidth', 2, 'color', 'blue', 'marker', 'o')
plot(dts,bsols, 'linewidth', 2, 'color', 'red', 'marker', 'o')
plot(dts,msols, 'linewidth', 2, 'color', 'k', 'marker', 'o')
plot(dts,rsols, 'linewidth', 2, 'color', 'k', 'marker', 'x')
xlabel('\Delta{t}'),ylabel('y(t)')

figure;
ea_f =diff(fsols)
ea_b =diff(bsols)
ea_m =diff(msols)
ea_r =diff(rsols)
hold on
plot(dts(2:end),abs(ea_f), 'linewidth', 2, 'color', 'blue', 'marker', 'o')
plot(dts(2:end),abs(ea_b), 'linewidth', 2, 'color', 'red', 'marker', 'o')
plot(dts(2:end),abs(ea_m), 'linewidth', 2, 'color', 'k', 'marker', 'o')
plot(dts(2:end),abs(ea_r), 'linewidth', 2, 'color', 'k', 'marker', 'x')
% set(gcf,'renderer','zbuffer');
% hgexport(gcf,'-clipboard')

figure;
loglog(dts(2:end),abs(ea_f), 'linewidth', 2, 'color', 'blue', 'marker', 'o');hold on
loglog(dts(2:end),abs(ea_b), 'linewidth', 2, 'color', 'red', 'marker', 'o');hold on
loglog(dts(2:end),abs(ea_m), 'linewidth', 2, 'color', 'k', 'marker', 'o');hold on
loglog(dts(2:end),abs(ea_r), 'linewidth', 2, 'color', 'k', 'marker', 'x');hold on
xlabel('\Delta t'),ylabel('y,E_a')
grid on
% set(gcf,'renderer','zbuffer');
% hgexport(gcf,'-clipboard')

y_ex =0.135335283236613;
et_f =y_ex-fsols
et_b =y_ex-bsols 
et_m =y_ex-msols 
et_r =y_ex-rsols 
figure;
loglog(dts,abs(et_f), 'linewidth', 2, 'color', 'blue', 'marker', 'o');hold on
loglog(dts,abs(et_b), 'linewidth', 2, 'color', 'red', 'marker', 'o');hold on
loglog(dts,abs(et_m), 'linewidth', 2, 'color', 'k', 'marker', 'o');hold on
loglog(dts,abs(et_r), 'linewidth', 2, 'color', 'k', 'marker', 'x');hold on
xlabel('\Delta t'),ylabel('y,E_t')
% set(gcf,'renderer','zbuffer');
% hgexport(gcf,'-clipboard')
% 
% loglog(dts(1:end-1),abs(diff(et_f)), 'linewidth', 2, 'color', 'blue', 'marker', '+');hold on
% loglog(dts(1:end-1),abs(diff(et_b)), 'linewidth', 2, 'color', 'red', 'marker', '+');hold on
% loglog(dts(1:end-1),abs(diff(et_m)), 'linewidth', 2, 'color', 'k', 'marker', '+');hold on
% xlabel('\Delta t'),ylabel('y,E_a')
% set(gcf,'renderer','zbuffer');
% hgexport(gcf,'-clipboard')

A =[log(dts(2:end)'), ones(length(dts)-1,1)];
pl =(A'*A)\A'*log(ea_f')

A =[log(dts'), ones(length(dts),1)];
pl =(A'*A)\A'*log(et_f')