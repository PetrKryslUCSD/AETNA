function r =  mirror(p,c,n)
    r = p;
    r.GPath=mirror(r.GPath,c,n);
    n =n/norm(n);
    cm =[p.xy(:,1)*0+c(1),p.xy(:,2)*0+c(2)];
    r.xy = p.xy - 2*[((p.xy-cm)*n')*n(1),((p.xy-cm)*n')*n(2)];
end