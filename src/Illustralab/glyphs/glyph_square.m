function g= glyph_square(Sidelength,Edgecolor,Fillcolor)

    g=GPath_polygon([-1,-1;+1,-1;+1,+1;-1, +1;-1,-1;]*Sidelength/2);
    g.edgecolor =Edgecolor;
    g.color = Fillcolor;
    g.linestyle ='-';
    g.linewidth =2;
end