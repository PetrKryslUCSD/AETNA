% Evaluate the mass matrix of the structure
% XY34 = array of two rows, one for joint 3 and one for joint 4: their
%      coordinates in the X and Y direction
function M =tcant_mass(XY34)
    [XY,en,A,E,rho,W,Widx,addM,addMidx,...
        neqf,maxtipd,Lowestfreq] =tcant_data;
    XY([3,4],:) =XY34;
    neqt=2*size(XY,1);% total of equations
    M=zeros(neqt);% global  mass
    for e=1:size(en,1)
        DeltaX=diff(XY(en(e,:),1));
        DeltaY=diff(XY(en(e,:),2));
        L= sqrt(DeltaX^2+DeltaY^2);
        eeq = [2*en(e,1)-[1,0],2*en(e,2)-[1,0]];
        M(eeq,eeq)=M(eeq,eeq)+rho*A(e)*L/2*eye(4);
    end
    D =zeros(size(M,1),1); % Add additional mass
    D([2*addMidx-1,2*addMidx]) =addM;
    M=M+ diag(D);
end
