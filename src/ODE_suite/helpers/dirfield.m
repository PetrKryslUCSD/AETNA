% Compute the components of the direction field.
%
% [t, y, u, v] = dirfield (funhandle, tmin, tmax, ymin, ymax, tnint,ynint)
%
% funhandle =Right-hand side function handle, 
% tmin, tmax= limits of the range of the independent variable (time), 
% ymin, ymax= limits of the range of the dependent variable, 
% tnint = number of intervals along the independent variable,
% ynint = number of intervals along the dependent variable,
%  Output:
% t, y, u, v= arrays needed by the quiver function
function [t, y, u, v] = dirfield (funhandle, tmin, tmax, ymin, ymax, tnint,ynint)
    tstep = (tmax - tmin) / tnint;
    ystep = (ymax - ymin) / ynint;
    t = zeros((tnint+1)*(ynint+1), 1);
    y = zeros((tnint+1)*(ynint+1), 1);
    u = zeros((tnint+1)*(ynint+1), 1);
    v = zeros((tnint+1)*(ynint+1), 1);
    k = 1;
    tp = tmin;
    for i=1:tnint+1
        yp = ymin;
        for j=1:ynint+1
            vvec = feval (funhandle, tp, [yp]');
            t(k) = tp;
            y(k) = yp;
            u(k) = 1;
            v(k) = vvec(1);
            k = k + 1;
            yp = yp + ystep;
        end
        tp =tp + tstep;
    end
end

  
