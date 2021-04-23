function r =  rotate(p,A)
    r=p;
    r.GPath_polygon = rotate(p.GPath_polygon,A);
end