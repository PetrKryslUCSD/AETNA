function s = subsasgn(s,index,val)
    switch index.type
        case '()'
            s.GPath_polygon = subsasgn(s.GPath_polygon,index,val);
        case '.'
            switch index.subs
                otherwise
                    s.GPath_polygon = subsasgn(s.GPath_polygon,index,val);
            end
    end
end