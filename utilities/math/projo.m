% The remaining part of the normal projection.
% function vo = projo (v, n) 
function vo = projo (v, n)
vo = v - projn (v, n);
