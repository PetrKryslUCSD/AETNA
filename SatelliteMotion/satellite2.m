% Solve the motion of the satellite and plot the entire trajectory
clear all
[G,M,R,v0,r0]=satellite_data;
dt=0.125*60;% in seconds
te=50*3600; % seconds
f=@(t,z)([z(4:6);-G*M*z(1:3)/(norm(z(1:3))^3)]);

opts=odeset('InitialStep',dt,'reltol',1e-6);%)
opts=odeset('InitialStep',dt);%)
[t,z]=ode23t(f,[0,te],[r0;v0],opts);

[xs,ys,zs]=sphere(80);
p=surf2patch(R*xs,R*ys,R*zs);
patch('Vertices',p.vertices,'Faces',p.faces,...
    'FaceColor','blue','EdgeColor','none','FaceAlpha',0.5);
hold on
l=line(z(:,1),z(:,2),z(:,3));
set(l,'linewidth',1)
xlabel('X'),ylabel('Y'),zlabel('Z')
axis equal vis3d
lighting flat
light('Position',[-1 -2 1],'Style','infinite');

figure(gcf)
view(2);
set(gca,'position', [0.2, 0.2, 0.7,0.65]);
[xs,ys,zs]=sphere(20);
r=R/6;
p=surf2patch(r*xs,r*ys,r*zs);
p=patch('Vertices',p.vertices,'Faces',p.faces,...
    'FaceColor','red','EdgeColor','none');

set(gca,'xlim',[-2e7-R,4e7+R]);
set(gca,'ylim',[-2e7-R,5e7+R]);
% set(gca,'xlim',[min(z(:,1))-R,max(z(:,1))+R]);
% set(gca,'ylim',[min(z(:,2))-R,max(z(:,2))+R]);
set(gca,'zlim',[min(z(:,3))-R,max(z(:,3))+R]);
xs=get(p,'XData');
ys=get(p,'YData');
zs=get(p,'ZData');
xyz=z(end,:);
set(p,'XData',xs+xyz(1));
set(p,'YData',ys+xyz(2));
set(p,'ZData',zs+xyz(3));
set(gca,'position', [0.2, 0.25, 0.7,0.6]);
