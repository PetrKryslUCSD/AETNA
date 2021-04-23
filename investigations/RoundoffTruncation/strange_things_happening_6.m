% Strange things happening in computer arithmetic: example 6


% Will the real minimum please stand up?
rm=realmin('double');
while rm/2~= 0
    rm=rm/2;
end
rm

