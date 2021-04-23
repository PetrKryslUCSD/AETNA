function p = render(p)
    color = [];
    if ~isempty(p.GPath.color)
        color =p.GPath.color;
    end
    linestyle = '-';
    if ~isempty(p.linestyle)
        linestyle =p.linestyle;
    end
    linewidth= 2;
    if ~isempty(p.linewidth)
        linewidth =p.linewidth;
    end
    edgecolor = [];
    if ~isempty(p.edgecolor)
        edgecolor =p.edgecolor;
    end
    if ~isempty(color)
        patch('xdata',p.xy(:,1),'ydata',p.xy(:,2),  'edgecolor', color, 'Facecolor', color);
    end
    if ~isempty(edgecolor)
        plot(p.xy(:,1),p.xy(:,2),  'color',edgecolor,'linestyle',linestyle,'linewidth',linewidth);
    end
    if ~isempty(p.decorations)
        if (length(p.decorations)>=1)  && (~isempty(p.decorations{1}))
            a=p.decorations{1} ;
            anchor =a.anchor;
            a.anchor =p.xy(2:-1:1,:);
            if isempty(a.color)
                a.color =edgecolor;
            end
            render(a);
            a.anchor =anchor;% reset the anchor to what it used to be
        end
        if (length(p.decorations) >1)  && (~isempty(p.decorations{2}))
            a =p.decorations{2};
            anchor =a.anchor;
            a.anchor =p.xy(end-1:end,:);
            if isempty(a.color)
                a.color =edgecolor;
            end
            render(a);
            a.anchor =anchor;% reset the anchor to what it used to be
        end
    end
end