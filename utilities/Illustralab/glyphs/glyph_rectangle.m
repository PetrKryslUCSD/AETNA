function g= glyph_rectangle(Dimensions,Edgecolor,Fillcolor)
    S =[-1,-1;+1,-1;+1,+1;-1, +1;-1,-1;];
    g=GPath_polygon([S(:,1)*Dimensions(1)/2,S(:,2)*Dimensions(2)/2]);
    g.edgecolor =Edgecolor;
    g.color = Fillcolor;
    g.linestyle ='-';
    g.linewidth =2;
end