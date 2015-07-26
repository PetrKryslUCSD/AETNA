% One way of computing the machine epsilon.
function myeps=theeps(where)
    myeps=where;
    while (where ~= where+myeps)
        myeps=myeps/2;
    end
    myeps=myeps*2;
end