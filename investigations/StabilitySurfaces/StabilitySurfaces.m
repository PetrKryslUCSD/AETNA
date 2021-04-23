% Visualize the amplification factor (stability surfaces)
% Note: comment out or uncomment an appropriate line depending on which
% integrator you're interested in:

xlow =-3.2; xhigh= 0.9;
ylow =-3.2; yhigh= 3.2;
n=100;
% This code fragment is to explain how the arrays for surf 
% may be constructed
% x=zeros(n,n); y=zeros(n,n); z=zeros(n,n);
% for k =1:n
%     for m =1:n
%         x(k,m) =xlow +(k-1)/(n-1)*(xhigh-xlow);
%         y(k,m) =ylow +(m-1)/(n-1)*(yhigh-ylow);
%         dtlambda = x(k,m) + 1i*y(k,m);
%         z(k,m) = abs(1 + dtlambda + 0.5*dtlambda.^2);
%     end
% end

% Here it is done much more efficiently and succinctly
[x,y] = meshgrid(linspace(xlow,xhigh,n),linspace(ylow,yhigh,n));
dtlambda = x + 1i*y;

% Here comment out or uncomment an appropriate line depending on which
% integrator you're interested in:
% Modified Euler
z = abs(1 + dtlambda + 0.5*dtlambda.^2);
% % Backward Euler
% z = 1./abs(1 - dtlambda);
% % Trapezoidal
% z = abs(1 + dtlambda/2)./abs(1 - dtlambda/2);
% % Forward Euler
% z = abs(1 + dtlambda);
% % Fourth order explicit Runge-Kutta
% z = abs(1+ dtlambda.^1/1+ ...
%      dtlambda.^2/2+ dtlambda.^3/6+ dtlambda.^4/24)
% % Trapezoidal
% z = abs(1 + dtlambda/2)./abs(1 - dtlambda/2);
% Implicit Modified Euler
% z = abs(1./(1 - dtlambda + 0.5*dtlambda.^2));

% plotting
surf(x,y,z,'edgecolor','none')
hold on
[C,H] =  contour3(x,y,z,[1, 1],'k')
set(H,'linewidth', 3)
axis([-4 0.6 -4 4 0 8])
axis equal, 
xlabel ('Re (\Delta{t}\lambda)')
ylabel ('Im (\Delta{t}\lambda)')
