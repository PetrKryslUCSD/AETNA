% Naive L U decomposition implementation; 
%
% function [l,u] = naivelu3(a)
% 
% This function does not perform pivoting, that is no row or column exchanges are performed. 
% comparative speed: Quite speedy
%
% (C) 2002 Petr Krysl
%
function [l,u] = naivelu3(a)
[n m] = size(a);
if n ~= m
   error('Matrix must be square!')
end

l=eye(n,n);
u=zeros(n,n);
for col=1:n-1
    col1=col+1;
    alli=col1:n;
    l(alli,col)=a(alli,col)/a(col,col); % col of L    
    a(alli,alli)=a(alli,alli)-l(alli,col)*a(col,alli);
end
u=triu(a);
