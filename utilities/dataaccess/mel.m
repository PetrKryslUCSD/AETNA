% The function returns elements of the array given by the indexes supplied
% as varargin.
% 
% function out = mel(A,varargin)
% 
% Example:
% mel(abs(diag(D)),1:6)
%
% This is only needed  because of  Matlab design: one cannot use array
% indexing into the result  of some function call. The resulting array
% needs to be passed into a function where  it can be indexed and the
% result returned.
 
% Copyright 2009 Petr Krysl
% 
function out = mel(A,varargin)
    out=A(varargin{:});
end
