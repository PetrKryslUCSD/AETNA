function s = subsasgn(s,index,val)
    switch index.type
        case '()'
            s.GPath_arc = subsasgn(s.GPath_arc,index,val);
        case '.'
            switch index.subs
                otherwise
                    s.GPath_arc = subsasgn(s.GPath_arc,index,val);
            end
    end
end