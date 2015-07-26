% Compute QR factorization using modified Gram-Schmidt.
%
% function [Q,R] = gsqr (A)
%
% Function to transform the basis consisting of the columns of the
% non-singular square matrix A into an orthonormal basis consisting of
% the columns of Q using the modified Gram-Schmidt algorithm.
% Usage:
% [Q,R] = gsqr (A)
%
function [Q,R] = gsqr (A)
    % Check that the input matrix is square
    [m,n] = size(A);
    if (m < n)
        disp('Error: matrix A has not sufficient rank: more columns than rows');
        Q = zeros(m,n); % return something initialized
        R = eye(m,n); % return something initialized
        return
    end
    
    R = zeros(n,n); % initialize R
    
    for col = 1:n % for the first, second, third, ..., m-th column of Q
        R(col,col) = norm(A(:,col));
        if (abs(R(col,col)) < eps)
            error(['Matrix is singular']);
        end
        A(:,col) = A(:,col)/R(col,col); % normalize column
        for ncol = col+1:n
            R(col,ncol) = A(:,col)'*A(:,ncol);
            A(:,ncol) = A(:,ncol) -  R(col,ncol) * A(:,col); % subtract projection
        end
    end
    Q=A; % output Q
end