% Strange things happening in computer arithmetic: example 1

%% Rather inexact result for a "nice" number

a= 0;
for i=1: 10000
    a=a+0.0001;
end
a
% a =
%
%    0.999999999999906