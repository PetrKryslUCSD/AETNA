% Vector-norm demo
%
% function vecnordemo(p)
%
% p= Choose which norm this should be, p=1,2,inf
% 
function vecnordemo(p)
    axis(1.2*[-1,1,-1,1]);
    axis square
    hold on;
    for a=0:pi/100:2*pi
        x=cos(a);
        y=sin(a);
        v=[x; y];
        vn=v/norm(v,n);
        plot(vn(1),vn(2),'ko','markersize', 2);
    end
    a=pi/3;
    x=cos(a);
    y=sin(a);
    v=[x; y];
    vn=v/norm(v,n);
    arrow([0,0],vn);
    grid on
    labels('$x_1$','$x_2$')