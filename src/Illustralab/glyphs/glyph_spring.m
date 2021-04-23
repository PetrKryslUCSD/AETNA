function g= glyph_spring(xs,xe,Width)

    Length =norm(xe-xs);
    sa =(xe(2)-xs(2))/Length;
    ca =(xe(1)-xs(1))/Length;
    w =Length/16*Width;
    x = [0, 0;
        2.5, 0;
        3, w;
        4, -w;
        5, w;
        6, -w;
        7, w;
        8, -w;
        9, w;
        10, -w;
        11, w;
        12, -w;
        13, w;
        13.5, 0;
        16, 0];
    x(:,1) =x(:,1)/max(x(:,1))*Length;
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