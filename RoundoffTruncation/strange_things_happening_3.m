% Strange things happening in computer arithmetic: example 3


%%  Roundoff error in numerical differentiation

a=-333333
x= 40789.7511;
for h=0.1./10.^(1:10)
    h
    slope = ( (a*(x+h)) - (a*(x-h)) ) / (2*h)
    abs(a-slope)/abs(a)
    semilogx(h,slope,'ro','linewidth',3); hold on
end

