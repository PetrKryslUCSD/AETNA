function r = mirror(p,c,n)
    r = p;
    r.GPath=translate(r.GPath,A);
    n =n/norm(n);
    cxy =(p.xy*0+1)*c';
    r.xy = cxy + ((p.xy-cxy)*n')*(p.xy*0+1)*n';
end