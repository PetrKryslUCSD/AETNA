% Demonstration of highly magnified error
a=[0.835,0.667; 0.333, 0.266]
b=[0.168; 0.067]
x=a\b
db=1e-3*rand(size(b));
dx=a\db
norm(dx)/norm(x)
