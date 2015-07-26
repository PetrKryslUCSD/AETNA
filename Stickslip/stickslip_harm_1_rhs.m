% The right-hand side function for the stick-slip simulation; for first
% order form
function yderiv = stickslip_harm_1_rhs(t, y, varargin)
    [m,mus,mud,N,A,omega,vstick] = stickslip_harm_data;
    v =y(1);
    if (abs(v)<vstick)
        yderiv = [-mus*(N+A*sin(omega*t))/m*sign(v) + A/m*cos(omega*t)];
    else
        yderiv = [-mud*(N+A*sin(omega*t))/m*sign(v) + A/m*cos(omega*t)];
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
