function r = translate(p,A)
    r=p;
    r.GPath_arc = translate(p.GPath_arc,A);
end