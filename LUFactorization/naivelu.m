% Naive L U decomposition implementation; all in place
%
% function [l,u] = naivelu(a)
% 
% This function does not perform pivoting, that is no row or column exchanges are performed. 
% Comparative speed: Very slow
% (C) 2002 Petr Krysl
%
function [l,u] = naivelu(a)
[n m] = size(a);
if n ~= m
   error('Matrix must be square!')
end

for col=1:n-1
    piv=a(col,col);
    col1=col+1;
    for row=col1:n
        mul=-a(row,col)/piv;
        a(row,col1:end)=a(row,col1:end)+mul*a(col,col1:end);
        a(row,col)=-mul;
    end
end

l=tril(a,-1)+eye(n,n);
u=triu(a);
