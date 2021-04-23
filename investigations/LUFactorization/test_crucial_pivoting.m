% Test crucial pivoting
A= [0.4653, 0.1766, 0.8463, 0.7917
0.1805, 0.068507, 0.3284, 0.6952
0.7891, 0.236, -0.192259, 0.4891
0.09073, 0.6998, -2, 0.9205];

L=eye(size(A));
U =A;
[L(2:end,1),U] = lustep(U,1)
[L(3:end,2),U] = lustep(U,2)
[L(4:end,3),U] = lustep(U,3)


b=[0.242849598318169
   0.917424342049382
   0.269061586686018
   0.765500016621438];
% b=rand(4,1);
xa =U\(L\b)

[L,U,P]=lu(A)
xb =U\(L\P*b)

norm(A*xb-b)
norm(A*xa-b)


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
% 

