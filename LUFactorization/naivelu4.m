% Naive LU decomposition implementation.
%
% function [l,u] = naivelu4(a)
% 
% This function does not perform pivoting, that is no row or column exchanges are performed. 
% Comparative speed: Speedy
%
% (C) 2002 Petr Krysl
%
function [l,u] = naivelu4(a)
    [n m] = size(a);
    if n ~= m
        error('Matrix must be square!')
    end

    for col=1:n-1
        ks=col+1:n;
        ls=a(ks,col)/a(col,col); % col of L
        a(ks,ks)=a(ks,ks)-ls*a(col,ks);
        a(ks,col)=ls;
    end

    l=tril(a,-1)+eye(n,n);
    u=triu(a);
end