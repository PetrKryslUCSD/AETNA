% Assign to a number of variables on output the elements of the array on
% input.
% 
% function [varargout] = adeal(x)
% 
% Example:
% [A,B,c] = adeal( [1,2,3])
% A =
%      1
% B =
%      2
% c =
%      3
% 
% Copyright 2009 Petr Krysl
% 
function [varargout] = adeal(x)
    nout = max(nargout,1);
    s = length(x);
    for k=1:nout, varargout{k}= x(k); end
end
