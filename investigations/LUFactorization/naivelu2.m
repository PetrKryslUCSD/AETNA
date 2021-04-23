% Naive LU decomposition implementation; 
%
% function [l,u] = naivelu2(a)
% 
% This function does not perform pivoting, that is no row or 
% column exchanges are performed. 
% comparative speed: Slow
% 
% (C) 2002 Petr Krysl
%
function [l,u] = naivelu2(a)
[n m] = size(a);
if n ~= m
   error('Matrix must be square!')
end

for col=1:n-1 % for each column but the last
    piv=a(col,col); % pivot
    col1=col+1;
    a(col1:n,col)=a(col1:n,col)/piv; % col of L    
    % update submatrix A(col1:n,col1:n)
    for i=col1:n
        for j=col1:n
            a(i,j)=a(i,j)-a(i,col)*a(col,j); 
        end
    end
end

l=tril(a,-1)+eye(n,n);
u=triu(a);
