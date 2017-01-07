% Evaluates the minimum frequency of free vibration
% XY34 = array of two rows, one for joint 3 and one for joint 4: their
%      coordinates in the X and Y direction
function Frequency =tcant_frequency(XY34)
    [XY,en,A,E,rho,W,Widx,addM,addMidx,...
        neqf,maxtipd,Lowestfreq] =tcant_data;
    M =tcant_mass(XY34);
    K =tcant_stiffness(XY34);
    [V,D]=eig(K(1:neqf,1:neqf),M(1:neqf,1:neqf));% Solve the eigenvalue problem
    Frequency =min(sqrt(diag(D))/2/pi);
end
