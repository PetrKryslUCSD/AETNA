% Test the steepest descent and conjugate gradient solvers
n=196;
% A=kms(n,  0.5);
A = gallery('poisson',18); n=size(A,1);
% A = pdtoep(n);

b=rand(n,1);
x0 = 0*rand(n,1);
maxiter =n;
xref=(A\b);
% [V,D]=eig(A);
% diag(D)

Style = {'r--','r-','b-'};
for s={@SteepestAxb,@ConjGradAxb}
    solutionHistory = s{1}(A,b,x0,maxiter);
    
    e=zeros(1,size(solutionHistory,2));
    for j = 1:size(solutionHistory,2)
        e(j) =norm (solutionHistory(:,j)-xref);
    end
    semilogy (e,Style{1},'linewidth',3)
    labels ('Iteration','Norm of the error')
    grid on; hold on
    Style = Style(2:end);
end

% x = pcg(A,b,eps,maxiter);
% 
% norm(solutionHistory(:,end)-x)
% norm(solutionHistory(:,end)-xref)