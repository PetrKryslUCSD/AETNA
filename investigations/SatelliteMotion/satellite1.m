% Solving the motion of an Earth satellite, with animation
G=6.67428 *10^-11;% cubic meters per kilogram second squared;
M=5.9736e24;% kilogram
R=6378e3;% meters
v0=[-2900;-3200;0]*0.9;% meters per second
r0=[R+20000e3;0;0];% meters
dt=0.125*60;% in seconds
te=50*3600; % seconds
f=@(t,z)([z(4:6);-G*M*z(1:3)/(norm(z(1:3))^3)]);

opts=odeset('InitialStep',dt,'reltol',1e-6);
[t,z]=ode23(f,[0,te],[r0;v0],opts);

figure(gcf)
[xs,ys,zs]=sphere(80);
p=surf2patch(R*xs,R*ys,R*zs);
patch('Vertices',p.vertices,'Faces',p.faces,...
    'FaceColor','blue','EdgeColor','none','FaceAlpha',0.5);
hold on
line(z(:,1),z(:,2),z(:,3));
xlabel('X'),ylabel('Y'),zlabel('Z')
axis equal vis3d
lighting flat
light('Position',[-1 -2 1],'Style','infinite');

view(2);
set(gca,'position', [0.2, 0.2, 0.7,0.65]);
[xs,ys,zs]=sphere(20);
r=R/6;
p=surf2patch(r*xs,r*ys,r*zs);
p=patch('Vertices',p.vertices,'Faces',p.faces,...
    'FaceColor','red','EdgeColor','none');

set(gca,'xlim',[min(z(:,1))-R,max(z(:,1))+R]);
set(gca,'ylim',[min(z(:,2))-R,max(z(:,2))+R]);
set(gca,'zlim',[min(z(:,3))-R,max(z(:,3))+R]);
xs=get(p,'XData');
ys=get(p,'YData');
zs=get(p,'ZData');
% cameratoolbar
dt=60;
for j=1:1
    ts=t(1);
    for i=1:length(t)-1
        while t(i)>=ts+dt
            xyz=(ts+dt-t(i-1))/(t(i)-t(i-1))*z(i,:)+(t(i)-ts-dt)/(t(i)-t(i-1))*z(i-1,:);
            set(p,'XData',xs+xyz(1));
            set(p,'YData',ys+xyz(2));
            set(p,'ZData',zs+xyz(3));
            pause(0.0001);
            ts=ts+dt;
        end
    end
end
