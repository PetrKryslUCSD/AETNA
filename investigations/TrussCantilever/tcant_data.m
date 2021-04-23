% Truss cantilever data
function [XY,en,A,E,rho,W,Widx,addM,addMidx,...
        neqf,maxtipd,Lowestfreq] =tcant_data
    % coordinates of the joints
    XY = [7.0, 2.5; ...
        6., 3.5; ...
        7.0, -1.0; ...
        6.0, 1.5; ...
        0, -1; ...
        0, 1.5]*1000;% mm
    % Which joints are linked by the bars?
    en= [5,3;3,1;6,4;4,2;1,2;3,4;1,4;3,6];
    A= zeros(size(en,1),1)+pi*60*7;% cross-sectional areas mm^2
    E= 70000;% Young's modulus:  aluminum, MPa
    rho=2.700e-9;% mass density, 1000*kg/mm^3
    W=6000;% Live load, N
    Widx=[1, 2];% Live load at which joints?
    addM = 0.096;% additional mass, 1000*kg
    addMidx =[1];%  Mass at which joints?
    neqf=8;% number of free degrees of freedom
    maxtipd =10;%mm, Maximum deflection magnitude
    Lowestfreq =13;% Hertz
end