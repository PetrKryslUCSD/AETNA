% Perform one step of LU factorization
% 
function [ls,A] = lustep(A,col)
    n=size(A,1);
    ks=col+1:n;
    ls=A(ks,col)/A(col,col); % col of L
    A(ks,ks)=A(ks,ks)-ls*A(col,ks);
    A(ks,col)=0;
 end
