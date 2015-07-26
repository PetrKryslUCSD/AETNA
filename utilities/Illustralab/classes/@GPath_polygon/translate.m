function r = translate(p,A)
    r = p;
    r.GPath=translate(r.GPath,A);
    r.xy = [p.xy(:,1)+A(1),p.xy(:,2)+A(2)];
end