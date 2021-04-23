% Linked buildings, Power iteration for the standard problem
[M,K] = lb_prop;
A=M\K;
tol =1e-4; maxiter= 25;
% With this starting vector we are likely to get the ninth
% v=ones(size(A,1),1)+1e-3*rand(size(A,1),1);

% With this document are we are likely to get the 10th
v=ones(size(A,1),1)+1e-1*rand(size(A,1),1);

% With his starting vector we are likely to get the 10th
v=rand(size(A,1),1);

[lambda,v]=pwr2(A,v,tol,maxiter) 
sqrt(lambda)/(2*pi)
% for j=1:maxiter
%     [lambda,v]=pwr2(A,v,tol,1);
%     sqrt(lambda)/(2*pi)
% end