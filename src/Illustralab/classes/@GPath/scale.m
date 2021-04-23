function r = scale(p,A)
    r = p;
    if ~isempty(r.anchor)
        r.anchor=[r.anchor(:,1)+A(1),r.anchor(:,2)+A(2)];
        if length(A)==1
            r.anchor = [p.anchor(:,1)*A(1),p.anchor(:,2)*A(1)];
        else
            r.anchor = [p.anchor(:,1)*A(1),p.anchor(:,2)*A(2)];
        end
    end
end