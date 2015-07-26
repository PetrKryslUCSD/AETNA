% Compute the Householder matrix.
% 
% function H = Householder_matrix(a)
% 
% a= input vector (column)
%  
% To test it try explore_House
%
function H = Householder_matrix(a)
    if (a(1)>0) at1 =-norm(a);% choose the sign wisely
    else        at1 =+norm(a); end
    n=-a; n(1)=n(1)+at1;% this is the subtraction of a~-a
    H = eye(length(a))+(n*n')/(n'*a);% this is the formula
end
