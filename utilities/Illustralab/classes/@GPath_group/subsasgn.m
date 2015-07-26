function s = subsasgn(s,index,val)
    switch index.type
        case '()'
            s.GPath = subsasgn(s.GPath,index,val);
        case '.'
            switch index.subs
                case 'group'
                    s.group = val;
                otherwise
                    for i=1:length(s.group)
                        g=s.group{i};
                        s.group{i} = subsasgn(g,index,val);
                    end
            end
    end
end