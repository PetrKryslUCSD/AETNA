function b = subsref(s,index)
    switch index.type
        case '()'
            b = subsref(s.GPath,index);
        case '.'
            switch index.subs
                case 'group'
                    b = s.group;
                otherwise
                    b = subsref(s.GPath,index);
            end
    end
end