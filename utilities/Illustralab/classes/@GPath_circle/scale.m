function r = scale(p,A)
    r=p;
    r.GPath_arc = scale(p.GPath_arc,A);
end