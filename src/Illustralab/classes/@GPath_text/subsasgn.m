function s = subsasgn(s,index,val)
    switch index.type
        case '()'
            s.GPath = subsasgn(s.GPath,index,val);
        case '.'
            switch index.subs
                case 'xy'
                    s.xy = val;
                case 'text'
                    s.text = val;
                case 'fontname'
                    s.fontname=val;
                case 'fontsize'
                    s.fontsize=val;
                case 'fontangle'
                    s.fontangle=val;
                case 'horizontalalignment'
                    s.horizontalalignment = val;
                case 'verticalalignment'
                    s.verticalalignment = val;
                case 'backgroundcolor'
                    s.backgroundcolor=val;
                case 'interpreter'
                    s.interpreter=val;
                otherwise
                    s.GPath = subsasgn(s.GPath,index,val);
            end
    end
end