function r = translate(p,A)
    r = p;
    r.GPath=translate(r.GPath,A);
end