function r = mirror(p,c,n)
    r=p;
    r.GPath=mirror(r.GPath,c,n);
    for j=1:length(r.group ) 
        r.group{j} =mirror(r.group{j},c,n);
    end
end