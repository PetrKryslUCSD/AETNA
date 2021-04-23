function b = subsref(s,index)
    switch index.type
        case '()'
            b = subsref(s.GPath,index);
        case '.'
            switch index.subs
                case 'xy'
                    b = s.xy;
                case 'text'
                    b = s.text;
                case 'fontname'
                    b = s.fontname;
                case 'fontsize'
                    b = s.fontsize;
                case 'fontangle'
                    b = s.fontangle;
                case 'interpreter'
                    b = s.interpreter;
                case 'horizontalalignment'
                    b =s.horizontalalignment;
                case 'verticalalignment'
                    b =s.verticalalignment;
                case 'backgroundcolor'
                    b =s.backgroundcolor;
                otherwise
                    b = subsref(s.GPath,index);
            end
    end
end