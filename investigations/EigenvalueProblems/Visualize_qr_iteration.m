% Visualize the progression of QR iteration
tol=1e-6;
maxiter =20;
n = 6;
% A = rand(n); A0=A;
% A=(A+A')/2;
[Q,R]=qr(rand(n));
% A=Q'*diag([5,-4,5,3,2,1])*Q;
A=Q'*diag([5,-5,5,3,2,1])*Q;%2
% A=Q'*diag([5,5,5,5,5,-5])*Q;
% A=Q'*diag([-5,5,-5,5,5,-5])*Q;
% % A=Q'*diag(-[5,5,5,5,5,5])*Q;
% A=Q'*diag([5,5,5,5,5,3])*Q;
% A=Q'*diag([-3,3,4,4.5,5,7])*Q;%1
[V,D] =eig (A) ;

figure
for it = 1:maxiter
    A = qrstepW(A);
    diag(A)',showelemmag(A)
    labels(' Columns',' Rows')
    title(['Approx \lambda = [' num2str((diag(A)'),'%3.3f, ') ']'])
%     fig2eps( ['figure_qr_2_' num2str(it)],'renderer','painters')
end
% close all