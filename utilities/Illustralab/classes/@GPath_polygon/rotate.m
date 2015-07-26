function r =  rotate(p,A)
    r = p;
    r.GPath=rotate(r.GPath,A);
    R = [cos(A),sin(A);-sin(A),cos(A)];
    r.xy = p.xy*R;
end