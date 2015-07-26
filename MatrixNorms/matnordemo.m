% Matrix-norm demo
%
% function matnordemo(A,p)
%
% A= 2 x 2 matrix
% p= Choose which norm this should be, p=1,2,inf
%
% Examples:
% matnordemo([2 -0.2; -1.5 3],2)
% A = [1, 2; 1, 1.]
% matnordemo(A, 2)
% matnordemo(inv(A), 2)
% A = [1, 2; 1, 1.9]
% matnordemo(A, 2)
% A = [1, 2; 1, 1.99]
% matnordemo(A, 2)
% matnordemo(inv(A), 2)
% A = [1, 2; 1, 1.999]
function matnordemo(A,p)
    plot([0],[0],'go');
    axis square
    hold on;
    xmin=inf;
    ymin=inf;
    xmax=0;
    ymax=0;
    for a=0:pi/100:2*pi
        x=cos(a);
        y=sin(a);
        v=[x; y];
        vn=v/norm(v,p);
        Avn=A*vn;
        plot([vn(1),Avn(1)],[vn(2),Avn(2)],'m-o');
        xmin=min(xmin,min(vn(1),Avn(1)));
        ymin=min(ymin,min(vn(2),Avn(2)));
        xmax=max(xmax,max(vn(1),Avn(1)));
        ymax=max(ymax,max(vn(2),Avn(2)));
    end
    axis([min(xmin,ymin) max(xmax,ymax) min(xmin,ymin) max(xmax,ymax)]);
    grid on