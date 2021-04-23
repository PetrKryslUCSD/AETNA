clc

All=GPath_group();
All.group ={};

Frame=GPath_polygon([-1,-1;2, 2]);
Frame.edgecolor ='w';
Frame.color = [];
Frame.linestyle ='none';
Frame.linewidth =1;
All= append(All,Frame);

Glyph=glyph_rectangle([6,3],'k','y');
All= append(All,Glyph);

Glyph= glyph_circle(1.8,'k','w');
Glyph =translate (Glyph,[-1.6,-1.3]);
All= append(All,Glyph);

Glyph= glyph_circle(1.8,'k','w');
Glyph =translate (Glyph,[+1.6,-1.3]);
All= append(All,Glyph);

Glyph=glyph_spring([-8, 0],[-3,0],2.1);
All= append(All,Glyph);

Glyph=glyph_damper([8, 0],[3, 0],2.1);
All= append(All,Glyph);

Glyph=glyph_rectangle([16 +1.2+1.2, 0.7],'k','k');
Glyph =translate (Glyph,[0,-3.5]);
All= append(All,Glyph);

Glyph=glyph_rectangle([1.2, 6.4],'k','k');
Glyph =translate (Glyph,[-8.6,-1.5]);
All= append(All,Glyph);

Glyph=glyph_rectangle([1.2, 6.4],'k','k');
Glyph =translate (Glyph,[8.6,-1.5]);
All= append(All,Glyph);

% Glyph=glyph_cartesian_axes_labels([-1, +5],[-2, +2],'\mathrm{Re}','\mathrm{Im}');
% Glyph.interpreter='latex';
% All= append(All,Glyph);

t1 =GPath_text([0,2.05],'m');
t1.fontname ='Times';
t1.fontsize =32;
t1.fontangle ='italic';
t1.horizontalalignment='center';
t1.color ='k';
t1.interpreter='latex';
All= append(All,t1);

t1 =GPath_text([-6,1.6],'k');
t1.fontname ='Times';
t1.fontsize =32;
t1.fontangle ='italic';
t1.horizontalalignment='center';
t1.color ='k';
t1.interpreter='latex';
All= append(All,t1);

t1 =GPath_text([6,1.6],'c');
t1.fontname ='Times';
t1.fontsize =32;
t1.fontangle ='italic';
t1.horizontalalignment='center';
t1.color ='k';
t1.interpreter='latex';
All= append(All,t1);

g= glyph_vector( [0, 0],[2, 0], 1.1);
g.linewidth =2;
All= append(All,g);

Glyph= glyph_circle(0.3,'k','w');
% Glyph =translate (Glyph,[+1.6,-1.2]);
All= append(All,Glyph);

t1 =GPath_text([ 1.2,0.8],'x');
t1.fontname ='Times';
t1.fontsize =32;
t1.fontangle ='italic';
t1.horizontalalignment='center';
t1.color ='k';
t1.interpreter='latex';
All= append(All,t1);

figure; hold on
set(gca,'Units','centimeter')
render(All)
axis equal
% grid on
axis off