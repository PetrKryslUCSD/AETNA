clc

All=GPath_group();
All.group ={};

Frame=GPath_polygon([-1,-1;2, 2]);
Frame.edgecolor ='w';
Frame.color = [];
Frame.linestyle ='none';
Frame.linewidth =1;
All= append(All,Frame);


Glyph=glyph_cartesian_axes([-1, +5],[-2, +2],'k');
All= append(All,Glyph);

Glyph=glyph_cartesian_axes_labels([-1, +5],[-2, +2],'\mathrm{Re}','\mathrm{Im}');
Glyph.interpreter='latex';
All= append(All,Glyph);

g= glyph_vector( [0, 0],[2, 1.2], 0.25);
g.linewidth =4;
All= append(All,g);
g= glyph_vector( [4, 0],-[2, 1.2], 0.);
g.linestyle ='--';
All= append(All,g);
g= glyph_vector( [0, 0],[2, -1.2], 0.25);
g.linewidth =4;
All= append(All,g);
g= glyph_vector( [4, 0],[-2, 1.2], 0.);
g.linestyle ='--';
All= append(All,g);
g= glyph_vector( [0, 0],[4, 0], 0.25);
g.linewidth =4;
g.edgecolor ='r';
All= append(All,g);

t1 =GPath_text([0.8,0.7],'a');
t1.fontname ='Times';
t1.fontsize =18;
t1.fontangle ='italic';
t1.horizontalalignment='center';
t1.color ='k';
t1.interpreter='latex';
All= append(All,t1);

t1 =GPath_text([0.8,-0.9],'\overline{a}');
t1.fontname ='Times';
t1.fontsize =18;
t1.fontangle ='italic';
t1.horizontalalignment='center';
t1.color ='k';
t1.interpreter='latex';
All= append(All,t1);

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
axis off
grid on
% axis off