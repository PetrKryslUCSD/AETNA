% Hilbert matrix example
n=3;
a=hilb(n);
[v,d] =eig(a);
b=1e-3*v(:, n)
x=a\b
db=1e-3*v(:, 1);
dx=a\db
norm(dx)/norm(x)
