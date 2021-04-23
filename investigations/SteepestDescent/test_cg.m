% Very simple test problem for the conjugate gradient solver
A=[cos(30/180*pi)*cos(30/180*pi), sin(30/180*pi)*cos(30/180*pi);
    sin(30/180*pi)*cos(30/180*pi), sin(30/180*pi)*sin(30/180*pi)]+...
    2/3*[cos(-30/180*pi)*cos(-30/180*pi), sin(-30/180*pi)*cos(-30/180*pi);
    sin(-30/180*pi)*cos(-30/180*pi), sin(-30/180*pi)*sin(-30/180*pi)];
b=[0.013 -0.031]'/2;
x0 = [0;0];
maxiter =34;
A\b
% solutionHistory = SteepestAxb(A,b,x0,maxiter);
solutionHistory = ConjGradAxb(A,b,x0,maxiter)

e=zeros(1,size(solutionHistory,2));
for j = 1:size(solutionHistory,2)
    e(j) =norm (solutionHistory(:,j)-(A\b));
end 
semilogy (e,'r-')
labels ('Iteration','Norm of the error')
grid on