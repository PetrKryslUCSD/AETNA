% Draw the structure

% Note that we are using the data from the current workspace!
xy=XY;
% XY34 = array of two rows, one for joint 3 and one for joint 4: their
%      coordinates in the X and Y direction
xy([3,4],:) =XY34;

clf;%figure;
hold on
set(gca,'Units','centimeter')

Gray = [1, 1, 1]*0.8;

All=GPath_group();
All.group ={};

Glyph=glyph_rectangle(1000*[1,4],Gray,Gray);
Glyph =translate (Glyph,[-500,750]);
All= append(All,Glyph);

for e=1:size(en,1)
    DeltaX=diff(xy(en(e,:),1));
    DeltaY=diff(xy(en(e,:),2));
    L= sqrt(DeltaX^2+DeltaY^2);
    Glyph=GPath_polygon([xy(en(e,:),1),xy(en(e,:),2)]);
    Glyph.edgecolor ='k';
    Glyph.color = [];
    Glyph.linestyle ='-';
    Glyph.linewidth =2;
    All= append(All,Glyph);
    t1 =GPath_text(sum([xy(en(e,:),1),xy(en(e,:),2)])/2-2*[100,100],['' num2str(e)]);
    t1.fontname ='Times';
    t1.fontsize =20;
    t1.fontangle ='italic';
    t1.horizontalalignment='center';
    t1.color ='k';
    t1.interpreter='latex';
    All= append(All,t1);
end

for i=1:size(xy,1)
    Glyph = glyph_circle(200,'r','r');
    Glyph = translate (Glyph,xy(i,:));
    All = append(All,Glyph);
    t1 =GPath_text(xy(i,:)+3*[100,100],['' num2str(i)]);
    t1.fontname ='Times';
    t1.fontsize =20;
    t1.fontangle ='italic';
    t1.horizontalalignment='center';
    t1.color ='k';
    t1.interpreter='latex';
    All= append(All,t1);
end

render(All);
hold on
axis equal
% grid on
axis off

% fig2eps(['figure_tcant'  '.eps'])