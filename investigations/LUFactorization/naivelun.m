% Naive L U decomposition implementation; NOT IN-PLACE
% does not perform pivoting, that is no row or column exchanges are performed. 
%
% (C) 2002 Petr Krysl
%
function [l,u] = naivelun(a)
[n m] = size(a);
if n ~= m
   error('Matrix must be square!')
end
l=eye(n,n);
for col=1:n-1
    col1=col+1;
    l(col1:n,col)=a(col1:n,col)/a(col,col);
    for row=col1:n
        a(row,col1:end)=a(row,col1:end)-l(row,col)*a(col,col1:end);
    end
end
u=triu(a);
