% Solve nonlinear equations which describe the intersections of level curves
% of two surfaces.

xlow =-2; xhigh= 2;
ylow =-2; yhigh= 2;
n=100;
[x,y] = meshgrid(linspace(xlow,xhigh,n),linspace(ylow,yhigh,n));


f = (x.^2 + 3*y.^2)/2 -2;
% surf(x,y,f,'edgecolor','none','facealpha', 0.5) 
hold on
[C,H] =  contour3(x,y,f,[0,0]);
set(H,'edgecolor','k','linewidth', 2);

g = x.*y +3/4;
% surf(x,y,g,'edgecolor','none','facealpha', 0.5) 
hold on
[C,H] =  contour3(x,y,g,[0,0]);
set(H,'edgecolor','r','linewidth', 2,'facealpha', 0.5);

axis equal, 
xlabel ('x')
ylabel ('y')
zlabel ('f(x, y), g(x, y)')
set(gca, 'xlim', [-5,5 ]/2 )
set(gca, 'ylim', [-5,5 ]/2 )
set(gcf,'renderer','opengl');

F=@(x,y) [((x.^2 + 3*y.^2)/2 -2); (x.*y +3/4)];
J=@(x,y) [x, 3*y; y, x];

w0= [-0.5;0.5];
w=w0-J(w0(1),w0(2))\F(w0(1),w0(2))
w0=w;

w=w0-J(w0(1),w0(2))\F(w0(1),w0(2))
w0=w;


w=w0-J(w0(1),w0(2))\F(w0(1),w0(2))
w0=w;

h=0.1;
Ja=@(x,y)[(F(x+h,y)-F(x,y))/h, (F(x,y+h)-F(x,y))/h]

w0= [-0.5;0.5];
w=w0-Ja(w0(1),w0(2))\F(w0(1),w0(2))
w0=w;

w=w0-Ja(w0(1),w0(2))\F(w0(1),w0(2))
w0=w;

w=w0-Ja(w0(1),w0(2))\F(w0(1),w0(2))
w0=w;