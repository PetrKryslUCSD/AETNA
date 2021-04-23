% Steepest descent algorithm for quadratic-form objective functions.
% 
% function solutionHistory = SteepestAxb(A,b,x0,maxiter)
%  
% A= matrix
%      Note: the matrix A is assumed to be symmetric.
% b= right hand side vector
% x0= initial guess of the solution
% maxiter= maximum number of iterations allowed
% 
% Sample test problem
% A=[cos(30/180*pi)*cos(30/180*pi), sin(30/180*pi)*cos(30/180*pi);
%     sin(30/180*pi)*cos(30/180*pi), sin(30/180*pi)*sin(30/180*pi)]+...
%     2/3*[cos(-30/180*pi)*cos(-30/180*pi), sin(-30/180*pi)*cos(-30/180*pi);
%     sin(-30/180*pi)*cos(-30/180*pi), sin(-30/180*pi)*sin(-30/180*pi)];
% b=[0.013 -0.031]'/2;
% x0 = [0;0];
% maxiter =4;
% 
function solutionHistory = SteepestAxb(A,b,x0,maxiter)
    solutionHistory =zeros(length(x0),maxiter+1);
    x=x0;
    for iter=1:maxiter
        solutionHistory(:,iter) =x;
        x = SteepestDescentQF_step(A,b,x);
    end
    solutionHistory(:,end) =x;
end

function x = SteepestDescentQF_step(A,b,x0)
    r = b-A*x0;
    x = x0 + (dot(r,r)/dot(A*r,r))* r;
end
        
        
    
    