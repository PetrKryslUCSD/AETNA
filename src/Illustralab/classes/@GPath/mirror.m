function r =  mirror(p,c,n)
    r = p;
    if ~isempty(r.anchor)
        n =n/norm(n);
        cxy =(p.anchor*0+1)*c';
        r.anchor = cxy + ((p.anchor-cxy)*n')*(p.anchor*0+1)*n';
    end
end