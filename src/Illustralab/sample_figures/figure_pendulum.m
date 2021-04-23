clc

All=GPath_group();
All.group ={};

Frame=GPath_polygon([-2,-4;2, 2]*2);
Frame.edgecolor ='w';
Frame.color = [];
Frame.linestyle ='none';
Frame.linewidth =1;
All= append(All,Frame);


Gray =[0.47, 0.47, 0.47];
Black =[0,0,0];
White =[1,1,1];
Bob_location =[0, -3.2];

Suspension0=GPath_polygon([0,0;Bob_location]);
Suspension0.edgecolor =Black;
Suspension0.color = [];
Suspension0.linestyle ='--';
Suspension0.linewidth =1;
All= append(All,Suspension0);

Suspension=GPath_polygon([0,0;Bob_location]);
Suspension.edgecolor =Black;
Suspension.color = [];
Suspension.linestyle ='-';
Suspension.linewidth =2;
Suspension =rotate(Suspension, 25/180*pi);
All= append(All,Suspension);

Bob=glyph_circle(0.4, Black,Black);
Bob = translate(Bob, Bob_location);
Bob =rotate(Bob, 25/180*pi);
All= append(All,Bob);

Arc1 =GPath_arc([0,0],Bob_location,25/180*pi);
Arc1.edgecolor= Black;
Arc1.linestyle='--';
Arc1.linewidth=1;
Arc1.decorations={ [],[]}
Arc1 =scale(Arc1,  0.7);
All= append(All,Arc1);

Support=glyph_rectangle([1.8,1],Gray, Gray);
Support = translate(Support, [0,  0.5]);
All= append(All,Support);

Magnet=glyph_rectangle([0.58, 0.35],Black, Black);
Magnet = translate(Magnet, [0.4,  -3.9]);
All= append(All,Magnet);

Magnet=glyph_rectangle([0.58, 0.35],Black, Black);
Magnet = translate(Magnet, [-0.4,  -3.9]);
All= append(All,Magnet);

Pin=glyph_circle(0.2, Black,White);
% Pin = translate(Pin, [1, -1.2]);
All= append(All,Pin);

t1 =GPath_text([1.5,-5.],'Permanent magnets');
t1.fontname ='Times';
t1.fontsize =10;
t1.fontangle ='italic';
t1.horizontalalignment='center';
t1.color ='k';
All= append(All,t1);

t1 =GPath_text([0.5,-2.8],'\phi');
t1.fontname ='Times';
t1.fontsize =10;
t1.fontangle ='italic';
t1.horizontalalignment='center';
t1.color ='k';
All= append(All,t1);

t1 =GPath_text([-2.,-5.9],'Repulsive force');
t1.fontname ='Times';
t1.fontsize =10;
t1.fontangle ='italic';
t1.horizontalalignment='center';
t1.color ='k';
All= append(All,t1);

y= (-0.5: 0.01: 0.5)';
f= (y.^3./( 0.00001+y.^4))/100;

Force=GPath_polygon([y,f]);
Force.edgecolor =Black;
Force.color = [];
Force.linestyle ='-';
Force.linewidth =3;
Force = scale (Force, [ 2.5, 10]);
Force = translate (Force, [ 0., -6.7]);
All= append(All,Force);

Force=GPath_polygon([y,f*0]);
Force.edgecolor =Black;
Force.color = [];
Force.linestyle ='-';
Force.linewidth =1;
Force = scale (Force, [ 2.5, 10]);
Force = translate (Force, [ 0., -6.7]);
All= append(All,Force);

Hand =glyph_pointing_hand(1.5);
Hand = rotate (Hand, 120/180*pi);
Hand = translate (Hand, [1.6,-3.2]);
All= append(All,Hand);

Hand =glyph_pointing_hand(1.5);
Hand = rotate (Hand, 160/180*pi);
Hand = translate (Hand, [0.6,-4.2]);
All= append(All,Hand);

figure; hold on
% set(gca,'Units','centimeter')
All = scale (All, 10);
render(All)
axis equal tight
grid on
axis off