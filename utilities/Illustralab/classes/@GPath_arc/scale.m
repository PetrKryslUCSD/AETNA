function r =  scale(p,A)
    r=p;
    r.GPath_polygon = scale(p.GPath_polygon,A);
end