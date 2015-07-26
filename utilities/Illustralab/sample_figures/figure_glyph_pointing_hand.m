clc

All=GPath_group();
All.group ={};

Frame=GPath_polygon([-2,-2;2, 2]*2);
Frame.edgecolor ='w';
Frame.color = [];
Frame.linestyle ='none';
Frame.linewidth =1;
All.group = cat(2,All.group,{Frame});

T =[-1,-1;1.3, 0.2;-0.3, 1.2;-1,-1;]*2;

Triangle=GPath_polygon(T);
Triangle.edgecolor ='k';
Triangle.color = 'r';
Triangle.linestyle ='-';
Triangle.linewidth =3;
All.group = cat(2,All.group,{Triangle});

g=glyph_pointing_hand(3);
g=rotate(g,-25/180*pi);
All.group = cat(2,All.group,{g});

for j= 1:size(T,1)
    c1=GPath_circle(T(j,:),0.15)
    c1.edgecolor ='k';
    c1.color ='w';
    c1.linestyle ='-';
    c1.linewidth =2;
    All.group = cat(2,All.group,{c1});
end


t1 =GPath_text([-3.5, 1.7],'T_j');
t1.fontname ='Times';
t1.fontsize =20;
t1.fontangle ='italic';
t1.color ='k';
All.group = cat(2,All.group,{t1});

t2 =GPath_text;
t2.xy=[-1,-3]
t2.text='\sum_k \alpha_k = 180^o'
t2.fontname='Times'
t2.fontsize=18
t2.fontangle='italic'
t2.interpreter='latex'
%GPath
t2.anchor=[]
t2.color='m'
All.group = cat(2,All.group,{t2});


figure; hold on
render(All)
axis equal tight
grid on
% axis off