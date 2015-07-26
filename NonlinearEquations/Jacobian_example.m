% Examples of numerical computation of the Jacobian
% example 1
F=@(z)[z(1)^2+2*z(1)*z(2)+z(2)^2;...
        z(1)*z(2)];
dFdz=@(z)[2*z(1)+2*z(2),2*z(1)+2*z(2);...
               z(2),     z(1)];
zbar = [-0.23;0.6];
Jac =dFdz(zbar)
Fbar =F(zbar);
h=1e-1;
Jac_approx =[(F(zbar+[1;0]*h)-Fbar)/h,    (F(zbar+[0;1]*h)-Fbar)/h]

% example 2
F=@(z)[cos(z(1));...
    z(2)^3*z(1)];
dFdz=@(z)[-sin(z(1)),     0;...
             z(2)^3,     3*z(2)^2*z(1)];
zbar = [0.61;-0.13];
Jac =dFdz(zbar)
Fbar =F(zbar);
h=1e-2;
Jac_approx =[(F(zbar+[1;0]*h)-Fbar)/h,    (F(zbar+[0;1]*h)-Fbar)/h]