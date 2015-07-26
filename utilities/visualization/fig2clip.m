% Export the figure to the clipboard (Windows only).
% 
% function fig2clip 
% 
function fig2clip
set(gcf,'renderer','zbuffer');
set(get(gca,'Title'),'fontsize',24)
figure(gcf);
hgexport(gcf,'-clipboard');
