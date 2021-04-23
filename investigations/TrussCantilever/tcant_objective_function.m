% The objective function for the cantilever truss.
% 
% XY34 = array of two rows, one for joint 3 and one for joint 4: their
%      coordinates in the X and Y direction
%
% Comment out or uncomment the two lines indicated at the bottom.
% This will change whether the optimization is for frequency or for static
% deflection.

function f =tcant_objective_function(XY34)
    [XY,en,minA,E,rho,W,Widx,addM,addMidx,...
        neqf,maxtipd,Lowestfreq] =tcant_data;
    V =tcant_volume(XY34)/tcant_volume(XY([3,4],:));
    Frequency =tcant_frequency(XY34);
    F=0.0008*exp(-200*(Frequency-Lowestfreq)/Lowestfreq);
    tipd=tcant_tip_deflection(XY34);
    D=norm(0.0001*exp(-200*((maxtipd-abs(tipd))/maxtipd)),Inf);
    f=V;% Initialize the value of the objective function
%     f=f+F;% + term for frequency constraint (uncomment or comment out)
    f=f+D;% + term for static deflection constraint (uncomment or comment out) 
end
