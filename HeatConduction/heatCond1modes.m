% Plot the modes of C\K
% note: this needs to be called from within heatCond1
nTemps =size(V,2);
for J= [1:4, 29, 30]
    plot(V(:,J))
    set (gca,'xlim', [1,nTemps]); 
        
    xlabel('Control volume Temperature'),ylabel('T')
    title (['Mode ' num2str(J)])
    %     fig2eps(['heat_conduction_wall_mode' num2str(J)]) 
end