function r =  scale(p,A)
    r = p;
    r.GPath=scale(r.GPath,A);
    if length(A)==1
        r.xy = [p.xy(:,1)*A(1),p.xy(:,2)*A(1)];
    else
        r.xy = [p.xy(:,1)*A(1),p.xy(:,2)*A(2)];
    end
end