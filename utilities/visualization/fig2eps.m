% Export a figure to PostScript (EPS).
%
% function fig2eps (name,varargin)
%
function fig2eps (name,varargin)
    if (~exist ('name','var'))
        name =tempname;
    end
    set(get(gca,'Title'),'fontsize',24)
    figure(gcf);
    [pathstr, name, ext] = fileparts(name) ;
    printeps(gcf,[ name '.eps'],varargin{:});
end
