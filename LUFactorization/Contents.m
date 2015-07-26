% LUFACTORIZATION
%
% Files
%   bslashtx              - Solve linear system (backslash)
%   bwsubs                - Backward substitution, i.e. solution of the upper triangular system U*x=c; 
%   cost_fwsubs           - Study the computational cost of Forward substitution
%   cost_lu               - Study the computational cost of built-in LU factorization w/ pivoting
%   elim_matrix           - Compute the elimination matrix.
%   elimination_process   - A =-rand(4)+rand(4)+1.15*eye(4)
%   fwsubs                - Forward substitution, i.e. solution of the lower triangular system L*c=b; 
%   lu_timings            - Run comparison timings of LU factorization algorithms
%   lustep                - Perform one step of LU factorization
%   lutx                  - LU factorization from Moler textbook
%   lutxnopiv             - LU Factorization from  Moler's book: Triangular factorization, textbook version
%   naivelu               - Naive L U decomposition implementation; all in place
%   naivelu1              - Naive L U decomposition implementation; 
%   naivelu2              - Naive LU decomposition implementation; 
%   naivelu3              - Naive L U decomposition implementation; 
%   naivelu4              - Naive LU decomposition implementation.
%   naivelun              - Naive L U decomposition implementation; NOT IN-PLACE
%   tcodes_slu            - slu  LU factorization of a square matrix using *no row exchanges*.
%   test_crucial_pivoting - Test crucial pivoting
%   test_naivelu          - Simple driver to test correctness of naïve LU  implementation
%   test_pivoting         - Demonstrate need for Pivoting
%   time_lu               - Time an implementation of the LU factorization.
