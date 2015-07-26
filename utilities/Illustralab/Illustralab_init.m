% Initialize the Illustralab toolbox.
%
% Usage: Illustralab_init()
%
function Illustralab_init()
    s=which('Illustralab_init');
    [pathstr, name, ext] =fileparts(s);
    sep = filesep;


    % Set paths
    add_subdirs_to_path ([pathstr], sep);
    if strcmp(version('-release'),'13')
        warning off MATLAB:m_warning_end_without_block
    end

%     disp(' ');
%     disp(['  Illustration tools']);
%     disp(['        Illustralab 1.0 (C)  08/13/2009, Petr Krysl.']);
%     disp('  Please report problems and/or bugs to: pkrysl@ucsd.edu');
%     disp(' ');
%     disp('  ')

    return;
end

function add_subdirs_to_path(d, sep)
    dl=dir(d);
    for i=1:length(dl)
        if (dl(i).isdir)
            if      (~strcmp(dl(i).name,'.')) && ...
                    (~strcmp(dl(i).name,'..')) && ...
                    (~strcmp(dl(i).name,'CVS')) && ...
                    (~strcmp(dl(i).name,'cvs')) && ...
                    (~strcmp(dl(i).name(1),'@'))
                addpath([d sep dl(i).name])
                add_subdirs_to_path([d sep dl(i).name], sep);
            end
        end
    end
    return;
end

