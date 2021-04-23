clc
A = [ 0.5, 0];
B = [1, 0];
C = [0, 1];

Frame=GPath_polygon([-.25,-.25;1.3, 1.3]);
Frame.edgecolor ='w';
 Frame.color = [];
Frame.linestyle ='none';
Frame.linewidth =1;

lin1=GPath_polygon([A;B]);
lin1.edgecolor ='k';
%  lin1.Color ='y';
lin1.linestyle ='-';
lin1.linewidth =4;

lin2 =lin1;
lin2=rotate(lin2, 45/180*pi);
lin2.edgecolor ='r';

a1 =GPath_arc([0, 0],B,45/180*pi);
a1.edgecolor='k';
a1.linestyle='--';
a1.linewidth=2;

figure; hold on
render( Frame)
render(lin1)
render(lin2)
render(a1)

axis equal tight
grid on
axis off