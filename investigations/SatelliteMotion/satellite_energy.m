% Compute and plot the total energy of the satellite
% Note: expects to have the solution [t,z] in the workspace
Km=0*t;
Vm=0*t;
for i=1:length(t)
    Km(i)=norm(z(i,4:6))^2/2;
    Vm(i)=-G*M/norm(z(i,1:3));
end
plot(t,Km+Vm,Style); hold on
xlabel('t [s]'),ylabel('T/m,K/m,V/m [m^2/s^2]')
