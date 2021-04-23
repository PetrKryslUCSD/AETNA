function g= glyph_damper(xs,xe,Width)

    Length =norm(xe-xs);
    sa =(xe(2)-xs(2))/Length;
    ca =(xe(1)-xs(1))/Length;
    w =Length/16*Width;
    x = [-4, 0;
        2.5, 0;
        2.5, w;
        13.5, w;
        13.5, -w;
        2.5, -w;
        2.5, 0;
        7.5, 0;
        7.5, w*0.8;
        6.5, w*0.8;
        8.5, w*0.8;
        7.5, w*0.8;
        7.5, -w*0.8;
        8.5, -w*0.8;
        6.5, -w*0.8;
        7.5, -w*0.8;
        7.5, 0;
        2.5, 0;
        2.5, w;
        13.5, w;
        13.5, 0;
        20, 0];
    x(:,1) =(x(:,1)+4)/(max(x(:,1))-min(x(:,1)))*Length;
    R= [ca,-sa;sa,ca];
    x=(R*x')';
    x(:,1) =x(:,1) +xs(1);
    x(:,2) =x(:,2) +xs(2);
    g=GPath_polygon(x);
    g.edgecolor ='k';
    g.color = [];
    g.linestyle ='-';
    g.linewidth =2;
    
end