% Three carriages, non-proportionally damped properties.
function [M,C,K,A,k1,k2,k3,c1,c2,c3] = properties_damped_non_proportional
    m= 1.3;  k = 61;   c =33.3; % Mass, stiffness, damping parameters
    M = [m,0,0;
        0,m,0;
        0,0,m]; % Mass matrix
    k1=k; k2=k; k3=k;
    K =[k1+k2,-k2,0;
        -k2,k2+k3,-k3;
        0,-k3,k3]; % Stiffness matrix
    c1=c; c2=0; c3=0;
    C =[c1+c2,-c2,0;
        -c2,c2+c3,-c3;
        0,-c3,c3];  % Damping matrix
    % First-order system matrix
    nparticles= size(K,1); % Number of masses
    A =[zeros(nparticles),eye(nparticles); -inv(M)*K,-inv(M)*C];
end