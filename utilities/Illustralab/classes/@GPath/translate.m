function r = translate(p,A)
    r = p;
    if ~isempty(r.anchor)
        r.anchor=[r.anchor(:,1)+A(1),r.anchor(:,2)+A(2)];
    end
end