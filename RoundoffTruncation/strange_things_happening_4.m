% Strange things happening in computer arithmetic: example 4


%% How is overflow or underflow handled?
a=intmax('int16');
if a+1 == a, disp('What the ...?'), end

intmin('int16')
intmin('int16')-1
intmin('int16')-100
