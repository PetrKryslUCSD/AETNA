% Truss cantilever data
function [X, kconn, dof, nfreedof, AppliedF, A, E, rho, addM, addMidx,...
        maxtipd, lowestfreq] = tcant_data
    % coordinates of the joints
    X = [7.0, 2.5; ...
        6., 3.5; ...
        7.0, -1.0; ...
        6.0, 1.5; ...
        0, -1; ...
        0, 1.5]*1000;% mm
    % Connectivity of the structure. Which joints are linked by the bars?
    kconn = [5,3;3,1;6,4;4,2;1,2;3,4;1,4;3,6];
    E= 70000;% Young's modulus:  aluminum, MPa
    rho=2.700e-9;% mass density, 1000*kg/mm^3
   
    % Degree of freedom data.
    % Array of degrees of freedom
    dof = [1, 2; 3, 4; 5, 6; 7, 8; 9, 10; 11, 12];% MODIFY
    nfreedof = 8;% number of free degrees of freedom;
     
    W = 6000;% Live load, N
    % Loading data.
    AppliedF = [0, -W; 0, -W; 0, 0; 0, 0; 0, 0];% MODIFY
        
    A = zeros(size(kconn,1),1)+pi*60*7;% cross-sectional areas mm^2

    addM = 0.096;% additional mass, 1000*kg
    addMidx = 1;%  Mass at which joints?
    
    maxtipd = 10;%mm, Maximum deflection magnitude
    lowestfreq =13; % Hertz
end