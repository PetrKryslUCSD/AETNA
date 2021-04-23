% Matrices that describe the properties of the *unconnected* buildings system 
function [M,K] = lb_prop_uc
    npc =5;% number of masses per column
    % Column Mass, stiffness, Links stiffness
    syms m kc kl 'real'
    M = m*eye(2*npc); % Mass matrix
    K =2*kc*diag(ones(2*npc,1))...
        -kc*diag(ones(2*npc-1,1),1)...
        -kc*diag(ones(2*npc-1,1),-1)...
        +kl*diag(ones(2*npc,1))...
        -kl*diag(ones(2*npc-5,1),5)...
        -kl*diag(ones(2*npc-5,1),-5); % Stiffness matrix
    K(1,1)= K(1,1)-kc;
    K(6,6)= K(6,6)-kc;
    K(5,6)= 0;
    K(6,5)= 0;
    % Substitute numbers
    m= 133;  kc = 61000;    kl =  0;
    M =eval(M);    K =eval(K);
end
