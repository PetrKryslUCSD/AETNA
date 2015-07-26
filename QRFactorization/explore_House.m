% Step-by-step exploration of Householder reflections
format short
A=rand(5); R=A % this is where R starts
Q=eye(size(A));% this is where Q starts
for k=1:size(A,1)-1
    H=eye(size(A));% Start with an identity...
    % ...and then put in the Householder matrix as a block
    H(k:end,k:end) = Householder_matrix(R(k:end,k))
    R= H*R % this matrix is becoming R
    Q= Q*H % this matrix is becoming Q
end
Q*Q'% check that this is an orthogonal matrix: should get identity

A-Q*R % check that the factorization is correct
R-Q'*A % another way to check
