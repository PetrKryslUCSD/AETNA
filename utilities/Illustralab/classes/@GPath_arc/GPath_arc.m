% Constructor for Graphics Path class of the type Circular arc.
% You must always pass one argument if you want to create a new
%  object.
function self = GPath_arc(varargin)
    if nargin==0 % Used when objects are loaded from disk
        self = init_fields;
        self = class(self, 'GPath_arc', GPath_polygon);
        return;
    end

    firstArg = varargin{1};
    if isa(firstArg, 'GPath_arc') %  used when objects are passed as arguments
        self = firstArg;
        return;
    end

    % We must always construct the fields in the same order,
    % whether the object is new or loaded from disk.
    % Hence we call init_fields to do this.
    self = init_fields;

    % attach class name tag, so we can call member functions to
    % do any initial setup
    self = class(self, 'GPath_arc', GPath_polygon);

    % Now the real initialization begins
    A=varargin{1};
    B=varargin{2};
    PHI=varargin{3};
    self.GPath_polygon.xy =segm(A,B,PHI);

    return;
end

function self = init_fields()
    % Initialize all fields to dummy values
    self.nul= []; 
end

function xy = segm(A,B,PHI)
    P = B - A;
    PSI = atan2(P(2),P(1));
    LP = norm(P);
    T = linspace(0,PHI,round(80*abs(PHI)/2/pi))';
    X = A(1) + LP*cos(PSI+T);
    Y = A(2) + LP*sin(PSI+T);
    xy=[X,Y];
end