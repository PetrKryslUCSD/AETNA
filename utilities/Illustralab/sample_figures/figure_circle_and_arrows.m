clc
A = [0, 0];
B = [1, 0];
C = [0, 1];

Frame=GPath_polygon([-1,-1;5, 4]);
Frame.edgecolor ='w';
Frame.color = [];
Frame.linestyle ='none';
Frame.linewidth =1;

big_arrow =GPath_arrow();
big_arrow.arrowsize = 0.6;
big_arrow.arrowstyle ='triangle';

small_arrow =GPath_arrow();
small_arrow.arrowsize = 0.23;
small_arrow.arrowstyle ='triangle';

a3=GPath_arc([0,0],[1,0],pi/2);
a3.xy;
a3.edgecolor ='r';
a4 = rotate(a3, pi/2);
a3=translate(a3, [3, 2]);
a3.decorations ={small_arrow,small_arrow};

c1=GPath_circle([0,0],0.5)
c1.edgecolor ='k';
c1.color =[];
c1.linestyle =':';
c1.linewidth =2;
c1.decorations ={small_arrow,small_arrow};

Axes=GPath_polygon([1.2*C;A;1.2*B;]);
Axes.edgecolor ='k';
Axes.color = [];
Axes.linestyle ='-';
Axes.linewidth =2;
Axes.decorations ={big_arrow,big_arrow};


figure; hold on
render( Frame)
render(Axes)
render(c1)
render(a3)
axis equal tight
grid on
% axis off