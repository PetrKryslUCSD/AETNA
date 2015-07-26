% Match the Name on input against the names of the fields of the structure
% S. 
% 
% function out = matchfieldname(S, Name)
% 
% out = matched field name or empty if there is no  field name that can be
% matched.  Note that the match is inexact.
% 
% Example:
% options = struct('initialstep', 0.01,'relTol',1e-3);
% out = matchfieldname(options, 'relTo')
% out =
% relTol
 
% Copyright 2009 Petr Krysl
% 
function out = matchfieldname(S, Name)
    out = [];
    f=fieldnames(S);
    for i= 1:length(f)
        lf{i} =lower (f{i});
    end 
    j=strmatch(lower(Name),lf);
    if (~isempty(j))
        out = f{j};
    end
end
