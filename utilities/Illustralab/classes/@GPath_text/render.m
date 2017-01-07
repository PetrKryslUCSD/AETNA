function p = render(p)
    if strcmp(p.interpreter,'latex')
        h=text(p.xy(:,1),p.xy(:,2),['$$' p.text '$$'],...
            'horizontalalignment',p.horizontalalignment,...
            'verticalalignment',p.verticalalignment,...
            'interpreter','latex');
    else
        h=text(p.xy(:,1),p.xy(:,2),[p.text],...
            'horizontalalignment',p.horizontalalignment,...
            'verticalalignment',p.verticalalignment);
    end
    if ~isempty(p.GPath.color)
       set(h,'color',p.GPath.color);
    end
    if ~isempty(p.backgroundcolor)
       set(h,'backgroundcolor',p.backgroundcolor);
    end
    if ~isempty(p.fontname)
       set(h,'fontname',p.fontname);
    end
    if ~isempty(p.fontsize)
       set(h,'fontsize',p.fontsize);
    end
    if ~isempty(p.fontangle)
       set(h,'fontangle',p.fontangle);
    end
end