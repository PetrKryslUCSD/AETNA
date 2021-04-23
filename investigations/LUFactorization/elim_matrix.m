% Compute the elimination matrix.
%
% function E =elim_matrix(A,i,j)
%
% Matrix to eliminate nonzero in A(i,j).
function E =elim_matrix(A,i,j)
    E =eye(size(A));
    E(i,j) =-A(i,j)/A(j,j);
end