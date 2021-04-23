% Match the Name on input against the names of the fields of the structure
% S. 
% 
% function out = matchfieldname(S, Name)
% 
% out = matched field name or empty if there is no  field name that can be
% matched.  Note that the match is inexact: as long as the match is unique,
% the match can be identified. 
% 
% Example:
% options = struct('initialstep', 0.01,'relTol',1e-3);
% out = matchfieldname(options, 'relTo')
% out =
% relTol
 
% Copyright 2015 Petr Krysl
% 
function out = matchfieldname(S, Name)
    out = [];
    f=fieldnames(S);
    for i= 1:length(f)
        lf{i} =lower (f{i});
    end 
    len=length(Name);
    while  len>0
        j=strmatch(lower(Name(1:len)),lf);
        if (~isempty(j))
            if (~isempty(out))
                error(['Ambiguous match of "' Name '"']);
            end
            out = f{j};
            return
        end
        len=len-1;
    end
end
