function r = translate(p,A)
    r=p;
    r.GPath_polygon = translate(p.GPath_polygon,A);
end