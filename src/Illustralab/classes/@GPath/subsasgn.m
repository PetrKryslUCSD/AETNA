function s = subsasgn(s,index,val)
    try
    s = builtin('subsasgn', s, index, val);
    catch, end; 
end