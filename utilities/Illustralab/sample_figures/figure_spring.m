clc

All=GPath_group();
All.group ={};

Frame=GPath_polygon([-1,-1;2, 2]);
Frame.edgecolor ='w';
Frame.color = [];
Frame.linestyle ='none';
Frame.linewidth =1;
All= append(All,Frame);


Glyph=glyph_spring([0, 0],[3, -3],2.1);
for i=1:4
Glyph =rotate (Glyph,18/180*pi);
All= append(All,Glyph);
end

Glyph=glyph_damper([0, 0],[3, 3],2.1);
for i=1:1
Glyph =rotate (Glyph,18/180*pi);
All= append(All,Glyph);
end

Glyph=glyph_cartesian_axes_labels([-1, +5],[-2, +2],'\mathrm{Re}','\mathrm{Im}');
Glyph.interpreter='latex';
All= append(All,Glyph);

t1 =GPath_text([1.8,0.2],'2\mathrm{Re}\, a=a+\overline{a}');
t1.fontname ='Times';
t1.fontsize =18;
t1.fontangle ='italic';
t1.horizontalalignment='center';
t1.color ='k';
t1.interpreter='latex';
All= append(All,t1);

figure; hold on
set(gca,'Units','centimeter')
render(All)
axis equal
grid on
% axis off