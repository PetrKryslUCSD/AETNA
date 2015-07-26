function s = subsasgn(s,index,val)
    switch index.type
        case '()'
            s.GPath = subsasgn(s.GPath,index,val);
        case '.'
            switch index.subs
                case 'arrowsize'
                    s.arrowsize=val;
                case 'arrowstyle'
                    s.arrowstyle=val;
                case 'arrowaspect'
                    s.arrowaspect=val;
                case 'followorientation'
                    s.followorientation=val;
                otherwise
                    s.GPath = subsasgn(s.GPath,index,val);
            end
    end
end