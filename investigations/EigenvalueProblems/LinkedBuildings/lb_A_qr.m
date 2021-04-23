% Solve for the frequencies of the linked buildings using qrstepS
[M,K] = lb_prop;
tol=1e-6;
maxiter =20;
[M,K] = lb_prop;
A=M\K; % matrix for the standard eigenvalue problem
figure
for it = 1:maxiter
    A = qrstepS(A);
    diag(A)',showelemmag(A)
    labels(' Columns',' Rows')
    title(['Approx \lambda = [' num2str((diag(A)'),'%3.3f, ') ']'])
%     fig2eps( ['figure_qr_2_' num2str(it)],'renderer','painters')
pause(0.5)
end
sqrt(sort(diag(A)'))/2/pi