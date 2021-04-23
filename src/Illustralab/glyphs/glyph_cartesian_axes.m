function g= glyph_cartesian_axes(xrange,yrange,Edgecolor,arrowsize)
    
    if (~exist('arrowsize','var'))
        arrowsize =max( [abs(diff(xrange)),abs(diff(yrange))])/20;
    end

    big_arrow =GPath_arrow();
    big_arrow.arrowsize = arrowsize;
    big_arrow.arrowstyle ='triangle';

    gx=GPath_polygon([min(xrange),0;max(xrange),0;]);
    gx.edgecolor =Edgecolor;
    gx.linestyle ='-';
    gx.linewidth =2;
    gx.decorations = {[],big_arrow};
    
    gy=GPath_polygon([0,min(yrange);0,max(yrange);]);
    gy.edgecolor =Edgecolor;
    gy.linestyle ='-';
    gy.linewidth =2;
    gy.decorations = {[],big_arrow};
    
    g=GPath_group();
    g.group ={gx,gy};
end