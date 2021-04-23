function r =  rotate(p,A)
    r = p;
    r.GPath=rotate(r.GPath,A);
end