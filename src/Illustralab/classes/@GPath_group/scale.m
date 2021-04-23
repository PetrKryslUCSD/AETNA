function r =  scale(p,A)
    r=p;
    r.GPath=scale(r.GPath,A);
    for j=1:length(r.group )
        r.group{j} =scale(r.group{j},A);
    end
end