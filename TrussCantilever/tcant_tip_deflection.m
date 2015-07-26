% Compute the deflection at the tip
function tipd =tcant_tip_deflection(XY34)
    [XY,en,minA,E,rho,W,Widx,addM,addMidx,...
        neqf,maxtipd,Lowestfreq] =tcant_data;
    K =tcant_stiffness(XY34);% stiffness matrix
    P=zeros(size(K,1),1);% global load vector
    P(2*Widx)=P(2*Widx)-W;% Add Live load
    % solution at the free degrees of freedom
    Uf=K(1:neqf,1:neqf)\P(1:neqf);
    tipd =Uf(1:4);% Tip deflection
end
