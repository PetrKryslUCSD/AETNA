% The right-hand side function for the stick-slip simulation; for second
% order form
function yderiv = stickslip_harm_2_rhs(t, y, varargin)
    [m,mus,mud,N,A,omega,vstick] = stickslip_harm_data;
    v =y(2);
    if (abs(v)<vstick)
        yderiv = [v;-mus*(N+A*sin(omega*t))/m*sign(v) + A/m*cos(omega*t)];
    else
        yderiv = [v;-mud*(N+A*sin(omega*t))/m*sign(v) + A/m*cos(omega*t)];
    end
end
function sv= sign(v)
    if (v>0)
        sv =+1;
    elseif (v<0)
        sv =-1;
    else
        sv =0;
    end
end
