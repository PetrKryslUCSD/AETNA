% Constructor of the map from data to colors.
%
% function retobj = data_colormap (varargin)
%
% See discussion of constructors in <a href="matlab:helpwin 'sofea/classes/Contents'">classes/Contents</a>. 
% Options:
%    range =array with range_min, and range_max, 
%    colormap =color map
% Call as:
% dcm=data_colormap(struct('range',[min(Uz),max(Uz)],'colormap',cmap));
%

function retobj = data_colormap (varargin)
    class_name='data_colormap';
    if (nargin == 0)
        self.rmin = [];
        self.rmax = [];
        self.colormap = [];
        self.ncolors = 0;
        self = class(self, class_name);
        retobj = self;
        return;
    elseif (nargin == 1)
        arg = varargin{1};
        if strcmp(class(arg),class_name) % copy constructor.
            retobj = arg;
            return;
        else
            options = varargin{1};
            self.rmin = min(options.range);
            self.rmax = max(options.range);
            self.colormap = hot;
            if (isfield(options,'colormap'))
                self.colormap = options.colormap;
            end
            self.ncolors = length(self.colormap(:,1));
            self = class(self, class_name);
            retobj = self;
            return;
        end
    else
        error('Illegal arguments!');
        return;
    end
    return;
end
