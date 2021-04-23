function r = rotate(p,A)
    r=p;
    r.GPath_arc = rotate(p.GPath_arc,A);
end