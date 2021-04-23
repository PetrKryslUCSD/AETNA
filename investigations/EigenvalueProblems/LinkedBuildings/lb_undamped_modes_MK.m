% Solve for the frequencies of the linked buildings from the generalized
% eigenvalue problem
[M,K] = lb_prop;
[V,D]=eig(K,M)
disp('Frequencies [Hz]')
sqrt(diag(D)')/(2*pi)

