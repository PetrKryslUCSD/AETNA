% Label axes in the current figure using the strings supplied. Note that
% all strings assume that the interpreter  of the text is LaTeX.  This
% allows for various formulas to be used for the labels, and makes it
% compatible with text in LaTeX-typeset manuscripts.
% 
% function labels (lx,ly,lz)
% 
% 
% Copyright 2009 Petr Krysl
% 
function labels (lx,ly,lz)
    if (~exist ('lx','var'))
        lx = [];
    end
    if (~exist ('ly','var'))
        ly = [];
    end
    if (~exist ('lz','var'))
        lz = [];
    end
    if (~isempty(lx))
        l=xlabel(lx);
        set(l,'interpreter','latex')
    end
    if (~isempty(ly))
        l=ylabel(ly);
        set(l,'interpreter','latex')
    end
    if (~isempty(lz))
        l=zlabel(lz);
        set(l,'interpreter','latex')
    end
end
