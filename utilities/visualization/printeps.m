function printeps(Fig,name, varargin)
%     if (~exist('resolution','var'))
%         resolution = 300;
%     end
    if (isempty(strfind(name, '.eps')))
        name =[name   '.eps'];
    end
    %     savefig(name, Fig,'eps')
    %     print( Fig,['-r' num2str(resolution)],'-depsc2', name)
    exportfig( Fig,name, 'width',6,'Color', 'rgb', 'fontmode','fixed', 'fontsize',18,varargin{:});
end