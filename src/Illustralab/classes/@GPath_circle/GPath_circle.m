% Constructor for Graphics Path class of the type Circular arc.
% You must always pass one argument if you want to create a new
%  object.
function self = GPath_circle(varargin)
    if nargin==0 % Used when objects are loaded from disk
        self = init_fields;
        self = class(self, 'GPath_circle', GPath_arc);
        return;
    end

    firstArg = varargin{1};
    if isa(firstArg, 'GPath_circle') %  used when objects are passed as arguments
        self = firstArg;
        return;
    end

    % We must always construct the fields in the same order,
    % whether the object is new or loaded from disk.
    % Hence we call init_fields to do this.
    self = init_fields;

    % attach class name tag, so we can call member functions to
    % do any initial setup
    self = class(self, 'GPath_circle', GPath_arc);

    % Now the real initialization begins
    A=varargin{1};
    R=varargin{2};
    self.GPath_arc = GPath_arc(A,A+[R,0],2*pi);

    return;
end

function self = init_fields()
    % Initialize all fields to dummy values
    self.arc = [];
end

function xy = segm(A,B,PHI)
    P = B - A;
    PSI = atan2(P(2),P(1));
    LP = norm(P);
    T = linspace(0,PHI,20)';
    X = A(1) + LP*cos(PSI+T);
    Y = A(2) + LP*sin(PSI+T);
    xy=[X,Y];
end