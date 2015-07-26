% Backward substitution, i.e. solution of the upper triangular system U*x=c; 
%
% function x=bwsubs(U,c)
% 
% Call as: 
%       x=bwsubs(U,c)
% where U=upper triangular matrix, and c= vector. 
%
% (C) 2008 Petr Krysl
%
function x=bwsubs(U,c)
    [n m] = size(U);
    if n ~= m, error('Matrix must be square!'); end
    x=zeros(n,1);
    x(n)=c(n)/U(n,n);
    for i=n-1:-1:1
        x(i)=(c(i)-U(i,i+1:n)*x(i+1:n))/U(i,i);
    end
end