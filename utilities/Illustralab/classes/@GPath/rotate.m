function r =  rotate(p,A)
    r = p;
    if ~isempty(r.anchor)
        R = [cos(A),sin(A);-sin(A),cos(A)];
        r.anchor = p.anchor*R;
    end
end