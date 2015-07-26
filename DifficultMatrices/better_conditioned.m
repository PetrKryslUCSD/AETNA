% Better-conditioned matrix from a least squares fitting
x= [0, 0.61, 1.13]';%  Abcissa
y= [1, 0.5, 0.513]';% Ordinate
dy= [0,0.00746,-0.006658]';% Perturbation of the Ordinate
A = [x.^2,x.^1,x.^0];% Least-squares matrix
p=(A'*A)\(A'*y)% Solve the normal equations of the least-squares
dp=(A'*A)\(A'*dy)  %solve the normal equations for the perturbation
norm(dy)/norm(y)% Relative error of the data
norm(dp)/norm(p)% Relative error of the solution
(norm(dp)/norm(p))/(norm(dy)/norm(y))% Not so bad
cond(A'*A)*norm(dy)/norm(y)% Why? The condition number!
% [V,D] =eig(A'*A)
x =linspace(0,1.13,100)';
plot(x,[x.^2,x.^1,x.^0]*p,'r-','linewidth',2); hold on
plot(x,[x.^2,x.^1,x.^0]*(p+dp),'k--','linewidth',2)
labels('$x$','$y$')
axis tight
