% Compute the Householder unit normal.
% 
% function n = Householder_normal (a)
%  
% a= input vector (column)
% 
function n = Householder_normal (a)
    if (a(1)>0) at1 =-norm(a);% choose the sign wisely
    else        at1 =+norm(a); end
    n=-a; n(1)=n(1)+at1;% this is the subtraction of a~-a
    n=n/sqrt(n'*n);% normalize
end
