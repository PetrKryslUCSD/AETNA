function g= glyph_dimension_line(x1,x2,offset,arrowsize,Edgecolor)

    d =(x2-x1)/norm(x2-x1);
    n= [-d(2),d(1)];

    big_arrow =GPath_arrow();
    big_arrow.arrowsize = arrowsize;
    if (norm(x2-x1) >3*arrowsize)
        big_arrow.arrowstyle ='triangle';
    else
        big_arrow.arrowstyle ='reversed_triangle';
    end

    gx=GPath_polygon([x1-n*offset;x2-n*offset]);
    gx.edgecolor =Edgecolor;
    gx.linestyle ='-';
    gx.linewidth =2;
    gx.decorations = {big_arrow,big_arrow};
    
    gx1=GPath_polygon([x1-0.35*n*offset;x1-n*offset]);
    gx1.edgecolor =Edgecolor;
    gx1.linestyle ='-';
    gx1.linewidth =2;
    
    gx2=GPath_polygon([x2-0.35*n*offset;x2-n*offset]);
    gx2.edgecolor =Edgecolor;
    gx2.linestyle ='-';
    gx2.linewidth =2;
    
    g=GPath_group();
    g.group ={gx,gx1,gx2};
end