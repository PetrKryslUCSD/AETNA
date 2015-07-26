% Slightly adjusted natural log which handles gracefully negative data
function f =mylog(A)
    if (A<0) f=-Inf;
    else f=reallog(A);
    end
end