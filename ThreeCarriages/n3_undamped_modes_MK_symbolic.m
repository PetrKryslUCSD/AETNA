% Generalized eigenvalue problem, symbolic solution, undamped. 
[M,C,K,A,k1,k2,k3,c1,c2,c3] = properties_undamped_symbolic;

% o= this is the square of omega
syms o2 real
% This is the characteristic equation
d=det(-o2*M+K)
m= 1.3;  k = 61;   c =0; % Mass, stiffness, damping parameters: Undamped system
d=subs(d) 
% Graphical solution
fplot(char(d), [0,160]); grid on
xlabel('o2');ylabel(char(d));
% Solve the Characteristic equation
s=solve(d,'o2')
% Get actual numbers
subs(s )

 