% Draw the structure
function tcant_draw(DV)

[X, kconn, dof, nfreedof, AppliedF, A, E, rho, addM, addMidx,...
        maxtipd, Lowestfreq] = tcant_data;
X(3, :) = DV(1:2);
X(4, :) = DV(3:4);

clf; %figure;
hold on
set(gca,'Units','centimeter')

Gray = [1, 1, 1]*0.8;

All=GPath_group();
All.group ={};

Glyph=glyph_rectangle(1000*[1,4],Gray,Gray);
Glyph =translate (Glyph,[-500,750]);
All= append(All,Glyph);

for e=1:size(kconn,1)
    DeltaX=diff(X(kconn(e,:),1));
    DeltaY=diff(X(kconn(e,:),2));
    L= sqrt(DeltaX^2+DeltaY^2);
    Glyph=GPath_polygon([X(kconn(e,:),1),X(kconn(e,:),2)]);
    Glyph.edgecolor ='k';
    Glyph.color = [];
    Glyph.linestyle ='-';
    Glyph.linewidth =2;
    All= append(All,Glyph);
    t1 =GPath_text(sum([X(kconn(e,:),1),X(kconn(e,:),2)])/2-2*[100,100],['' num2str(e)]);
    t1.fontname ='Times';
    t1.fontsize =20;
    t1.fontangle ='italic';
    t1.horizontalalignmkconnt='ckconnter';
    t1.color ='k';
    t1.interpreter='latex';
    All= append(All,t1);
end

for i=1:size(X,1)
    Glyph = glyph_circle(200,'r','r');
    Glyph = translate (Glyph,X(i,:));
    All = append(All,Glyph);
    t1 =GPath_text(X(i,:)+3*[100,100],['' num2str(i)]);
    t1.fontname ='Times';
    t1.fontsize =20;
    t1.fontangle ='italic';
    t1.horizontalalignmkconnt='ckconnter';
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