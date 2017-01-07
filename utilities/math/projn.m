% Normal projection of vector v into the direction of the unit vector n.
% function vn = projn (v, n) 
function vn = projn (v, n)
n=n/norm(n);
vn = (v' * n) * n;
end
