clc

All=GPath_group();
All.group ={};

Frame=GPath_polygon([-2,-2;2, 2]*2);
Frame.edgecolor ='w';
Frame.color = [];
Frame.linestyle ='none';
Frame.linewidth =1;
All= append(All,Frame);


Square=glyph_square(0.2,'k','y');
Square = translate(Square, [2, 1]);
All= append(All,Square);



Glyph=glyph_circle(0.4,'k','w');
Glyph = translate(Glyph, [1, -1.2]);
All= append(All,Glyph);

Glyph=glyph_rectangle([1.8,0.5],'k','c');
Glyph = translate(Glyph, [1, 2]);
All= append(All,Glyph);

t1 =GPath_text([1,2],'div grad T_j');
t1.fontname ='Times';
t1.fontsize =10;
t1.fontangle ='italic';
t1.horizontalalignment='center';
t1.color ='k';
All= append(All,t1);

figure; hold on
set(gca,'Units','centimeter')
render(All)
axis equal tight
grid on
% axis off