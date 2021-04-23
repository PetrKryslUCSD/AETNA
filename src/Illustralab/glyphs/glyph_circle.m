function g= glyph_circle(Diameter,Edgecolor,Fillcolor)

    g=GPath_circle([0,0],Diameter/2);
    g.edgecolor =Edgecolor;
    g.color = Fillcolor;
    g.linestyle ='-';
    g.linewidth =2;
end