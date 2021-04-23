% Convert a double to three strings, sign, exponent, mantissa
%
% [S,E,M]=double2SEM(x)
%
% Example:
% >> [S,E,M]=double2SEM(eps)
% S =
% 0
% E =
% 01111001011
% M =
% 0000000000000000000000000000000000000000000000000000
% bin2dec(E)
% ans =
%    971
% >> 2^(971-1023)
% ans =
%      2.220446049250313e-16
function [S,E,M]=double2SEM(x)
s=num2bins(x);
S=s(1);
E=s(2:12);
M=s(13:64);
end
