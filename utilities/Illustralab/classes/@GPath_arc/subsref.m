function b = subsref(s,index)
    switch index.type
        case '()'
            b = subsref(s.GPath_polygon,index);
        case '.'
            switch index.subs
                otherwise
                    b = subsref(s.GPath_polygon,index);
            end
    end
end