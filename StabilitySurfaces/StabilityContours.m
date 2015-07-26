% Visualize the amplification factor by plotting the level curve at 1.0


n=140;
xlim = 3.2; ylim = 3.2;
[x,y] = meshgrid(linspace(-xlim,xlim,n),linspace(-ylim,ylim,n));
dtlambda = x + 1i*y;
% Modified Euler
meul = abs(1 + dtlambda + 0.5*dtlambda.^2);
% Backward Euler
beul = 1./abs(1 - dtlambda);
% Trapezoidal
trap = abs(1 + dtlambda)./abs(1 - dtlambda);
% Forward Euler
feul = abs(1 + dtlambda);
% Fourth order explicit Runge-Kutta
rk4 = abs(1+ dtlambda.^1/1+ dtlambda.^2/2+ dtlambda.^3/6+ dtlambda.^4/24);
colors ='rgbcmk';
for s ={meul,beul,trap,feul,rk4}
    Stability =s{1};
%     surf(x,y,Stability,'edgecolor','none')
    hold on
    [C,H] =  contour3(x,y,Stability,[1, 1],colors(1));
    set(H,'linewidth', 3);
    colors =colors(2:end);
end
axis equal%, axis off
axis([-4 4 -4 4 0 8])
grid on
labels('$\mathrm{Re}(\Delta{t}\;\lambda)$','$\mathrm{Im}(\Delta{t}\;\lambda)$')
