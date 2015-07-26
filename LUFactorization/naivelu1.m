% Naive L U decomposition implementation; 
%
% function [l,u] = naivelu1(a)
% 
% This function does not perform pivoting, that is no row or column exchanges are performed. 
% 
% comparative speed: Quite speedy
%
% (C) 2002 Petr Krysl
%
function [l,u] = naivelu1(a)
[n m] = size(a);
if n ~= m
   error('Matrix must be square!')
end

for col=1:n-1
    piv=a(col,col);
    col1=col+1;
    ls=a(col1:end,col)/piv; % col of L    
    a(col1:end,col1:end)=a(col1:end,col1:end)-ls*a(col,col1:end);
    a(col1:end,col)=ls;
end

l=tril(a,-1)+eye(n,n);
u=triu(a);
