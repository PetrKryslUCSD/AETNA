% Create a permutation matrix.
% 
% function P = permmat (v)
% 
% Input: Consider an arbitrary matrix A.
% Vector v (the permutation vector) as input to permmat contains numbers
% of rows of A in the order in which they
% should appear in the *permuted* matrix P*A.
% 
function P = permmat (v)
    P =eye(length(v));
    P =P(v,:);
end
