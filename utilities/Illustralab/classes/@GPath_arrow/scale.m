function r =  scale(p,A)
    r = p;
     r.GPath=scale(r.GPath,A);
    r.Arrowsize = p.Arrowsize*A(1);
end
