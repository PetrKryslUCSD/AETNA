% Another way of computing the machine epsilon.
function myeps=theeps1(where)
    myeps=realmin(class(where));
    while (where+myeps == where)
        myeps=myeps*2;
    end
end