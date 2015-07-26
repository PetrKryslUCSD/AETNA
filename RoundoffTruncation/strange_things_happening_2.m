% Strange things happening in computer arithmetic: example 2

%% Have we added the same number?

a= 778945692579.7511;
b= 0.0001;
n= 1000000;
d= a;
e= 0;
for i=1: n
    d=d+b;
    e=e+b;
end
c= a + n*b;
c-a
d-a
e 
% ans =
%    100
% ans =
%     1.220703125000000e+002
% e =
%     1.000000000021961e+002
