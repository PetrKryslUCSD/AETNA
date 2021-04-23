% Analytical Conjugate Gradients for a 2 x 2 matrix
K =[sym('K11','real'),sym('K12','real');sym('K12','real'),sym('K22','real')];% stiffness
L =[sym('L1','real');sym('L2','real')];% load
X0 =[sym('X01','real');sym('X02','real')];% starting point
g=@(x)(x'*K-L');% compute gradient
a=@(x,d)(-g(x)*d)/(d'*K*d);% compute alpha
b=@(x,d)(g(x)*K*d)/(d'*K*d);% compute beta
 
d0 =-g(X0)';% first descent direction
X1 =X0 +a(X0,d0)*d0;% second point

d1 =b(X1,d0)*d0-g(X1)';% second descent direction
X2 =X1 +a(X1,d1)*d1;% final point

simplify(g(X2))% gradient at final point ~ 0