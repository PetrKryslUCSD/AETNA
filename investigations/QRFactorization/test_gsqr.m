% This script tests the Gram-Schmidt orthogonalization 
% as implemented in the gsqr() Matlab function.  The function is run three
% times on random matrices of different size, and the norm of the
% difference between the identity matrix and the product of Q
% transposed with itself, and between the identity and the product of Q
% with Q transposed, is used to measure the accuracy and correctness of
% the gramschmidt() algorithm.

disp('Testing gramschmidt for random matrices:');
for size = [ 3 15 66 ]
  a = rand (size);
  [q,r] = gsqr (a);
  fprintf (1, 'Size %d: ||Q^T*Q - I|| =%g, ||Q*Q^T - I|| =%g\n', size, norm(q'*q - eye(size)), norm(q*q' - eye(size)));
end
