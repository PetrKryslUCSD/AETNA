% examples of scalar-equation behaviors
lambda = 0.5;
rhsf =@(t,y) (lambda*y^1.3);
y0=1;
tspan =[0  4];
dts = [2, 1, 1/2, 1/4, 1/8, 1/16, 1/32];
dts = [2, 1, 1/2, 1/4, 1/8, 1/16, 1/32 1/64 1/128];
dts = [1/16, 1/32 1/64 1/128 1/256 1/512 1/1024 1/2048];

[t,sol] = ode23(rhsf, tspan, y0, odeset('reltol',1e-12,'abstol',1e-12));
y_ex =sol (end);

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
plot(dts,msols, 'linewidth', 2, 'color', 'k', 'marker', 'o')
xlabel('\Delta{t}'),ylabel('y(t)')

figure;
ea_f =diff(fsols)
ea_m =diff(msols)
hold on
plot(dts(2:end),abs(ea_f), 'linewidth', 2, 'color', 'blue', 'marker', 'o')
plot(dts(2:end),abs(ea_m), 'linewidth', 2, 'color', 'k', 'marker', 'o')
% set(gcf,'renderer','zbuffer');
% hgexport(gcf,'-clipboard')

figure;
loglog(dts(2:end),abs(ea_f), 'linewidth', 2, 'color', 'blue', 'marker', 'o');hold on
loglog(dts(2:end),abs(ea_m), 'linewidth', 2, 'color', 'k', 'marker', 'o');hold on
xlabel('\Delta t'),ylabel('y,E_a')
grid on
% set(gcf,'renderer','zbuffer');
% hgexport(gcf,'-clipboard')

et_f =y_ex-fsols
et_m =y_ex-msols 
figure;
loglog(dts,abs(et_f), 'linewidth', 2, 'color', 'blue', 'marker', 'o');hold on
loglog(dts,abs(et_m), 'linewidth', 2, 'color', 'k', 'marker', 'o');hold on
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