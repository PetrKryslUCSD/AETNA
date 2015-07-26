% The function returns elements of the array given by the indexes supplied
% as varargin.
% 
% function out = mel(A,varargin)
% 
% Example:
% mel(abs(diag(D)),1:6)
 
% Copyright 2009 Petr Krysl
% 
function out = mel(A,varargin)
    out=A(varargin{:});
end
