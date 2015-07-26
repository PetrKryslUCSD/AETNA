% Perform one step of Householder QR factorization
% 
% function [A,Q] = Householder  (A,Q)
% 
% Example:
% format short
% A=rand(4)
% Q=eye(size(A,1));
% for k=1:size(A,1)-1
%     H=eye(size(A,1));
%     [A(k:end,k:end),H(k:end,k:end)]= Householder  (A(k:end,k:end))
%     Q=H*Q;
% end
% Q*Q'
%
function [A,Q] = Householder  (A,Q)
    a=A(:,1);
    if (a(1)>0) at1 =-norm(a);
    else        at1 =+norm(a); end
    n=-a; n(1)=n(1)+at1;
    n=n/sqrt(n'*n);
    A =A-2*n*(n'*A);
    Q =Q-2*n*(n'*Q);
end
