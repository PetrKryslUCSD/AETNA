% Forward substitution, i.e. solution of the lower triangular system L*c=b; 
%
% function c=fwsubs(L,b)
% 
% Call as: 
%       c=fwsubs(L,b)
% where L=lower triangular matrix with ones on the diagonal, and b= right
%           hand side vector.  
%
% (C) 2008 Petr Krysl
%
function c=fwsubs(L,b)
    [n m] = size(L);
    if n ~= m,  error('Matrix must be square!');    end
    c=zeros(n,1);
    c(1)=b(1)/L(1,1);
    for i=2:n
        c(i)=(b(i)-L(i,1:i-1)*c(1:i-1))/L(i,i);
    end
end