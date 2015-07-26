% Driver to test HouseQR
format short
tic;
for i = 1:140
    A=rand(i);
    [Q,R] = HouseQR(A);
    [q,r] =qr(A);
    if (norm(Q-q)+norm(R-r)>1000*eps)
        norm(Q*R)-norm(q*r)
    end
end
toc


tic;
for i = 1:140
    A=rand(i);
    [Q,R] = HouseQR(A);
end
toc

tic;
for i = 1:140
    A=rand(i);
    [q,r] =qr(A); 
end
toc
