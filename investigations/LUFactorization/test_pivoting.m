% Demonstrate need for Pivoting
A= [0.4653, 0.1766, 0.8463, 0.7917
0.1805, 0.9188, 0.3244, 0.6952
0.7891, 0.236, 0.007259, 0.4891
0.09073, 0.6998, 0.9637, 0.9205];

[L,U]=lu(A)

P =perm_matrix(A,1,3)
A=P*A
L=eye(size(A));
A = gausselim_step(A,1)
A = gausselim_step(A,2)
A = gausselim_step(A,3)

% A= [0.4653, 0.1766, 0.8463, 0.7917
% 0.1805, 0.3188, 0.3244, 0.6952
% 0.7891, 0.236, 1.69, 0.4891
% 0.09073, 0.9, -3.637, 0.9205];
% A1=A;
% 
% [L1,U1]=lu(A1)
% 
% L=eye(size(A));
% P =perm_matrix(A,1,3)
% A=P*A
% A = gausselim_step(A,1)
% P =perm_matrix(A,2,4)
% A=P*A
% A = gausselim_step(A,2)
% P =perm_matrix(A,3,4)
% A=P*A
% A = gausselim_step(A,3)
% U=A;


