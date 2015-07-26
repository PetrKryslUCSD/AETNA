function s = subsasgn(s,index,val)
    switch index.type
        case '()'
            s.GPath = subsasgn(s.GPath,index,val);
        case '.'
            switch index.subs
                case 'xy'
                    s.xy = val;
                case 'linestyle'
                    s.linestyle=val;
                case 'linewidth'
                    s.linewidth=val;
                case 'edgecolor'
                    s.edgecolor=val;
                case 'decorations'
                    s.decorations=val;
                otherwise
                    s.GPath = subsasgn(s.GPath,index,val);
            end
    end
end