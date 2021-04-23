clc
A = [0, 0];
B = [1, 0];
C = [0, 1];

Frame=GPath_polygon([-.25,-.25;1.3, 1.3]);
Frame.edgecolor ='w';
 Frame.color = [];
Frame.linestyle ='none';
Frame.linewidth =1;

Outline=GPath_polygon([A;B;C;A]);
Outline.edgecolor ='k';
 Outline.color ='y';
Outline.linestyle ='-';
Outline.linewidth =4;

Axes=GPath_polygon([1.2*C;A;1.2*B;]);
Axes.edgecolor ='k';
 Axes.color = [];
Axes.linestyle ='-';
Axes.linewidth =2;

t1 =GPath_text(A,'1');
t1.fontname ='Times';
t1.fontsize =20;
t1.fontangle ='italic';
t1.color ='k';
t1 = translate(t1,[-0.1,-0.1]);

t2 =GPath_text(t1);
t2.xy = B;
t2.text = '2';
t2 = translate(t2,[ 0,-0.1]);

t3 =GPath_text(t1);
t3.xy = C;
t3.text = '3';
t3 = translate(t3,[ -0.13,0]);


t4 =GPath_text(t1);
t4.xy = B+[ 0.13,-0.1];
t4.text = '\xi';
t4.interpreter ='latex';

t5 =GPath_text(t1);
t5.xy = C+[ -0.13,0.23];
t5.text = '\eta';

t6 =GPath_text(t1);
t6.xy = [0.1, 0.35];
t6.text = 'P = (\xi,\eta)';
t6.interpreter ='';
t6.fontangle =[];

c1=GPath_circle(A,0.05)
c1.edgecolor ='k';
c1.color ='w';
c1.linestyle ='-';
c1.linewidth =4;

c2 =translate(c1, B);
c3 =translate(c1, C);
c4 = translate(c1, [0.53,0.43]);
c4= scale(c4, 0.5);

g1=GPath_group();
g1.group ={Outline,Axes,c1,c2,c3,t1,t2,t3,t4,t5,t6};
g1 = scale(g1, 0.7);
g1 = translate(g1, [0.7, 1.7]);
g1 = rotate(g1, 30/180*pi);



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
render(g1)
axis equal tight
grid on
axis off