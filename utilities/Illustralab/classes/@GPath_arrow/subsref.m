function b = subsref(s,index)
    switch index.type
        case '()'
            b = subsref(s.GPath,index);
        case '.'
            switch index.subs
                case 'arrowsize'
                    b = s.arrowsize;
                case 'arrowstyle'
                    b = s.arrowstyle;
                case 'arrowaspect'
                    b = s.arrowaspect;
                case 'followorientation'
                    b = s.followorientation;
                otherwise
                    b = subsref(s.GPath,index);
            end
    end
end