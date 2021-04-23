% Bad matrix
n=3;
a=[8, 5, 2; 21, 19, 16; 39, 48, 53]
b=[15, 56, 140]'
x=a\b
db=[1, 0, 0]';
dx=a\db
norm(dx)/norm(x)
