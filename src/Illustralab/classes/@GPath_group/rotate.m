function r =  rotate(p,A)
    r=p;
    r.GPath=rotate(r.GPath,A);
    for j=1:length(r.group )
        r.group{j} =rotate(r.group{j},A);
    end
end
