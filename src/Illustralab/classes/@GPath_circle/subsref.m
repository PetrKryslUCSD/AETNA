function b = subsref(s,index)
    switch index.type
        case '()'
            b = subsref(s.GPath_arc,index);
        case '.'
            switch index.subs
                otherwise
                    b = subsref(s.GPath_arc,index);
            end
    end
end