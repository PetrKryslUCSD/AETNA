% Format an integer number into a string by padding it on the left with zeroes.
% 
% function s=n2s0p(n) 
% 
function s=n2s0p(n)
if n<10
    s=['000' num2str(n)];
elseif n<100
    s=['00' num2str(n)];
elseif n<1000
    s=['0' num2str(n)];
else
    s=num2str(n);
end
end