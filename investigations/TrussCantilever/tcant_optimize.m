% Find the optimum solution
options = optimset('Display','iter',...
    'MaxFunEvals', 350000,...
    'MaxIter', 3000,...
    'TolX',1e-3,...
    'TolFun', 1.0e-3);
[XY,en,A,E,rho,W,Widx,addM,addMidx,...
        neqf,maxtipd,Lowestfreq] =tcant_data;
% XY34 = array of two rows, one for joint 3 and one for joint 4: their
%      coordinates in the X and Y direction
XY34 =    XY([3,4],:);
XY34 = fminsearch(@tcant_objective_function,XY([3,4],:),options);

disp(['Mass of the structure reduced to ', num2str(tcant_volume(XY34)/tcant_volume(XY([3,4],:))*100),'%'])
tipd =tcant_tip_deflection(XY34)
Frequency =tcant_frequency(XY34)
tcant_draw 
% fig2eps(['figure_tcant_F'  '.eps'])