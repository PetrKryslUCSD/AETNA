% 
% A =-rand(4)+rand(4)+1.15*eye(4)
A= [0.7960    0.7448    0.1201    0.0905
   -0.3649    1.2163   -0.3435   -0.5449
    0.0186   -0.0930    1.2036   -0.0012
   -0.1734   -0.6695   -0.0653    0.4113];
[L,U] =lu(A)
matrix2latex(A,4,',')

% i=1;
% A(2,i:end) =A(2,i:end)-A(2,i)/A(i,i)*A(i,i:end)
%matrix2latex(L,4,',')

E21 =elim_matrix(A,2,1)
E21*A
E31 =elim_matrix(E21*A,3,1)
E31*E21*A
E41 =elim_matrix(E31*E21*A,4,1)
E41*E31*E21*A

E32 =elim_matrix(E41*E31*E21*A,3,2)
E32*E41*E31*E21*A
E42 =elim_matrix(E32*E41*E31*E21*A,4,2)
E42*E32*E41*E31*E21*A

E43 =elim_matrix(E42*E32*E41*E31*E21*A,4,3)
E43*E42*E32*E41*E31*E21*A
matrix2latex(E43*E42*E32*E41*E31*E21*A,4,',')