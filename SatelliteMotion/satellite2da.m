% Satellite motion Driver. Tests a variety of integrators and plots energy
clear all
[G,M,R,v0,r0]=satellite_data;
dt=50*0.125*60;% in seconds
te=150*3600; % seconds
f=@(t,z)([z(4:6);-G*M*z(1:3)/(norm(z(1:3))^3)]);

opts=odeset('InitialStep',dt,'reltol',10^-4*eps);%)
opts=odeset('InitialStep',dt,'AbsTol',1e-3);%)
[t,z]=ode23(f,[0,te],[r0;v0],opts);Style ='r'; 
% [t,z]=ode45(f,[0,te],[r0;v0],opts);Style ='k'; 
% [t,z]=odebeul(f,[0,te],[r0;v0],opts);Style ='r'; 
% [t,z]=odeimeul(f,[0,te],[r0;v0],opts);Style ='r'; 
% [t,z]=odemeul(f,[0,te],[r0;v0],opts);Style ='b';
% [t,z]=odetrap(f,[0,te],[r0;v0],opts);Style ='g';
% [t,z]=oderk4(f,[0,te],[r0;v0],opts);Style ='k'; 
% [t,z]=oderk4adapt(f,[0,te],[r0;v0],opts);Style ='k';  
% [t,z]=oderk4adapt2(f,[0,te],[r0;v0],opts);Style ='k--'; 
% [t,z]=odefeuladapt(f,[0,te],[r0;v0],opts);Style ='b'; 
% [t,z]=ode23t(f,[0,te],[r0;v0],opts);Style ='r'; 
satellite_energy
% plot(t(2:end),diff(t), Style);hold on
figure (gcf)