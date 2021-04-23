% Evaluate the stiffness matrix of the structure
% XY34 = array of two rows, one for joint 3 and one for joint 4: their
%      coordinates in the X and Y direction
function K =tcant_stiffness(XY34)
    [XY,en,A,E,rho,W,Widx,addM,addMidx,...
        neqf,maxtipd,Lowestfreq] =tcant_data;
    XY([3,4],:) =XY34;
    neqt=2*size(XY,1);% Total equations, incl prescribed
    Z= zeros(2);
    Grbm= [-1,0,1,0];
    K=zeros(neqt);% global stiffness matrix
    for e=1:size(en,1)
        DeltaX=diff(XY(en(e,:),1));
        DeltaY=diff(XY(en(e,:),2));
        L= sqrt(DeltaX^2+DeltaY^2);
        R = [ DeltaX/L, DeltaY/L;
            -DeltaY/L, DeltaX/L];
        Grot = [R,Z; Z,R];
        eeq = [2*en(e,1)-[1,0],2*en(e,2)-[1,0]];
        K(eeq,eeq)=K(eeq,eeq)+Grot'*Grbm'*E*A(e)/L*Grbm*Grot;
    end
end