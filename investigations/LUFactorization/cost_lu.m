% Study the computational cost of built-in LU factorization w/ pivoting
ns=10:10:600;
ntrials=100;
t = [];
for n = ns
    A=rand(n);
    tic;
    for Trial = 1: ntrials
        [L,U,p]=lu(A,'vector');
    end
    t(end+1) =toc
end
t1=t;
plot(ns,t/ntrials)
labels 'Matrix size $n$' ' Time [s]'

% n=1000;
% A=rand(n);
%     tic;
%         [L,U,p]=lu(A,'vector');
%    toc 