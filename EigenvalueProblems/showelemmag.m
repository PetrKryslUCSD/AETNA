% Show the magnitude of matrix entries visually
% 
% Original design by David S. Watkins
% Modification by Petr Krysl
function showelemmag(A, logmag)
    if (~exist('logmag','var'))
        logmag =0;
    end
    figure(gcf);
    cm=gray(256);
    colormap(cm(end:-1:1,:));
    if (logmag)
         imagesc(log(abs(A)));
    else
        imagesc(abs(A));
    end
    axis ij square;
    shading faceted;
    view (2);
end
