function g= glyph_cartesian_axes_labels(xrange,yrange,xvariable,yvariable)

    arrowsize = max( [abs(diff(xrange)),abs(diff(yrange))])/20;
    
    gxv =GPath_text;
    gxv.xy=[max(xrange),-arrowsize];
    gxv.text=xvariable;
    gxv.fontname='Times';
    gxv.fontsize=16;
    gxv.fontangle='italic';
    
    gyv =GPath_text;
    gyv.xy=[-arrowsize,max(yrange)];
    gyv.text=yvariable;
    gyv.fontname='Times';
    gyv.fontsize=16;
    gyv.fontangle='italic';
    gyv.horizontalalignment='right';
   
    g=GPath_group();
    g.group ={gxv,gyv};
end