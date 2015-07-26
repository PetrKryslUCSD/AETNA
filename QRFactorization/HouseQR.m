% Compute QR factorization using Householder transformations.
% 
% function [Q,R] = HouseQR(A)
% 
function [Q,R] = HouseQR(A)
    m=size(A,1);
    Q=eye(m); R =A;
    for k=1:size(A,1)-1
        n = Householder_normal(R(k:end,k));
        R(k:end,k:end) =R(k:end,k:end)-2*n*(n'*R(k:end,k:end)); 
        Q(:,k:end)=Q(:,k:end)-2*(Q(:,k:end)*n)*n';
    end
end
