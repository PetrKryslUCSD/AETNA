clc
A = [0, 0];
B = [1, 0];
C = [0, 1];

Frame=GPath_polygon([-.25,-.25;1.3, 1.3]);
Frame.Edgecolor ='y';
 Frame.Color = [];
Frame.Linestyle ='none';
Frame.Linewidth =1;

Outline=GPath_polygon([A;B;C;A]);
Outline.Edgecolor ='k';
 Outline.Color ='y';
Outline.Linestyle ='-';
Outline.Linewidth =4;

Axes=GPath_polygon([1.2*C;A;1.2*B;]);
Axes.Edgecolor ='k';
 Axes.Color = [];
Axes.Linestyle ='-';
Axes.Linewidth =2;

t1 =GPath_text(A,'1');
t1.Fontname ='Times';
t1.Fontsize =20;
t1.Fontangle ='italic';
t1.Color ='k';
t1 = translate(t1,[-0.1,-0.1]);

t2 =GPath_text(t1);
t2.xy = B;
t2.Text = '2';
t2 = translate(t2,[ 0,-0.1]);

t3 =GPath_text(t1);
t3.xy = C;
t3.Text = '3';
t3 = translate(t3,[ -0.13,0]);


t4 =GPath_text(t1);
t4.xy = B+[ 0.13,-0.1];
t4.Text = '\xi';

t5 =GPath_text(t1);
t5.xy = C+[ -0.13,0.23];
t5.Text = '\eta';

t6 =GPath_text(t1);
t6.xy = [0.1, 0.35];
t6.Text = 'P = (\xi,\eta)';

c1=GPath_circle(A,0.05)
c1.Edgecolor ='k';
c1.Color ='w';
c1.Linestyle ='-';
c1.Linewidth =4;

c2 =translate(c1, B);
c3 =translate(c1, C);
c4 = translate(c1, [0.53,0.43]);
c4= scale(c4, 0.5);

figure; hold on
render( Frame)
render(Outline)
render(Axes)
render(c1)
render(c2)
render(c3)
render(t1)
render(t2)
render(t3)
render(t4)
render(t5)
render(t6)
render(c4)

axis equal tight
grid on
axis off