% Constructor for Graphics Path class of the type Circular arc.
% You must always pass one argument if you want to create a new
%  object.
function self = GPath_polygon(varargin)
    if nargin==0 % Used when objects are loaded from disk
        self = init_fields;
        self = class(self, 'GPath_polygon', GPath);
        return;
    end

    firstArg = varargin{1};
    if isa(firstArg, 'GPath_polygon') %  used when objects are passed as arguments
        self = firstArg;
        return;
    end

    % We must always construct the fields in the same order,
    % whether the object is new or loaded from disk.
    % Hence we call init_fields to do this.
    self = init_fields;

    % attach class name tag, so we can call member functions to
    % do any initial setup
    self = class(self, 'GPath_polygon', GPath);

    % Now the real initialization begins
    xy=varargin{1};
    self.xy = xy;

    return;
end

function self = init_fields()
    % Initialize all fields to dummy values
    self.xy = []; 
    self.linestyle=[];
    self.linewidth=[];
    self.edgecolor=[];
    self.decorations = {};
end
