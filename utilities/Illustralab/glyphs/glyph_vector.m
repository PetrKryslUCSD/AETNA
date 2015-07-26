function g= glyph_vector(Anchor,components,arrowsize)

    big_arrow =GPath_arrow();
    big_arrow.arrowsize = arrowsize;
    big_arrow.arrowstyle ='triangle';

    g=GPath_polygon([Anchor; Anchor + components]);
    g.edgecolor ='k';
    g.color = 'k';
    g.linestyle ='-';
    g.linewidth =2;
    g.decorations = {[],big_arrow};

end