% Steepest descent algorithm for quadratic-form objective functions.
% 
% function solutionHistory = ConjGradAxb(A,b,x0,maxiter)
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
function solutionHistory = ConjGradAxb(A,b,x0,maxiter)
    solutionHistory =zeros(length(x0),maxiter+1);
    x=x0;
    g = x'*A-b';
    d=-g';
    for iter=1:maxiter
        solutionHistory(:,iter) =x;
        alpha =(-g*d)/(d'*A*d);
        x = x + alpha* d;
        g = x'*A-b';
        beta =(g*A*d)/(d'*A*d);
        d =beta*d-g';
    end
    solutionHistory(:,end) =x;
end

        
    
function solutionHistory = ConjGradAxb(A,b,x0,maxiter)
    solutionHistory =zeros(length(x0),maxiter+1);
    x=x0;
    g = x'*A-b';
    d=-g';
    for iter=1:maxiter
        solutionHistory(:,iter) =x;
        Ad =A*d;
        rho =(d'*Ad);
        alpha =(-g*d)/rho;
        x = x + alpha*d;
        g = x'*A-b';
        beta =(g*Ad)/rho;
        d =beta*d-g';
    end
    solutionHistory(:,end) =x;
end    