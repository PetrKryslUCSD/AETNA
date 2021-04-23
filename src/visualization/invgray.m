%invgray   Inverse linear gray-scale color map
%   invgray(M) returns an M-by-3 matrix containing a gray-scale colormap.
%   invgray, by itself, is the same length as the current figure's
%   colormap. If no figure exists, MATLAB creates one.
%
%   For example, to reset the colormap of the current figure:
%
%             colormap(invgray)
%
%   See also gray.
function g = invgray(m)

if nargin < 1, m = size(get(gcf,'colormap'),1); end
g = (m-1:-1:0)'/max(m-1,1);
g = [g g g];
