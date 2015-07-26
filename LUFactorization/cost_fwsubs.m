% Study the computational cost of Forward substitution
ns=10:50:1600;
ntrials=100;
t = [];
for n = ns
    L =tril(rand(n))+sqrt(n)*eye(n);
    b =L(end,:)';
    tic;
    for Trial = 1: ntrials
        c=fwsubs(L,b);
    end
    t(end+1) =toc
end
t1=t;
plot(ns,t/ntrials)
labels 'Matrix size $n$' ' Time [s]'