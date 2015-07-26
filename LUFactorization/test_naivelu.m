% Simple driver to test correctness of naïve LU  implementation
function test_naivelu
for i=1:10
    for m=1:1000
        a=rand(i,i);
        [l,u]=naivelu(a);
        if norm(a-l*u) > 1000000*eps
            a, l*u, l, u
        end
    end
end
