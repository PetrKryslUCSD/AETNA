% LU Factorization from  Moler's book: Triangular factorization, textbook version
%   Modified by PK: removed pivoting
%   [L,U] = lutxnopiv(A) produces a unit lower triangular matrix L,
%   an upper triangular matrix U
function [L,U] = lutxnopiv(A)

[n,n] = size(A);
for k = 1:n-1
      i = k+1:n;
      A(i,k) = A(i,k)/A(k,k);
      A(i,i) = A(i,i) - A(i,k)*A(k,i); 
end
L = tril(A,-1) + eye(n,n);
U = triu(A);
