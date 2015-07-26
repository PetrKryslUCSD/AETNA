function r = translate(p,A)
    r=p;
    r.GPath=translate(r.GPath,A);
    for j=1:length(r.group ) 
        r.group{j} =translate(r.group{j},A);
    end
end