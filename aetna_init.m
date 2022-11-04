% Initialize the aetna toolbox.
% Usage: aetna_init
%
% Run this function before using the toolkit.
% This function needs to be run from within the AETNA
% folder. It adds all necessary folders from the AETNA toolkit
% to the Matlab path.
function aetna_init()
sep = filesep;
add_subdirs_to_path ([pwd], sep);
if strcmp(version('-release'),'13')
    warning off MATLAB:m_warning_end_without_block
end
set_graphics_defaults

disp(' ');
disp(['  An engineer''s toolkit of numerical algorithms']);

disp(['        AETNA 7.0 (C) 11/03/2022, Petr Krysl.']);
% disp(['        AETNA 6.0 (C) 05/13/2020, Petr Krysl.']);
% disp(['        AETNA 5.0 (C) 02/13/2019, Petr Krysl.']);
% disp(['        AETNA 4.1 (C) 12/13/2017, Petr Krysl.']);
% disp(['        AETNA 4.0 (C) 12/13/2016, Petr Krysl.']);
% disp(['        AETNA 3.0 (C)  9/13/2013, Petr Krysl.']);
%     disp(['        AETNA 2.0 (C)  7/13/2011, Petr Krysl.']);
%     disp(['        AETNA 1.1 (C)  10/13/2009, Petr Krysl.']);
disp('  Please report problems and/or bugs to: pkrysl@ucsd.edu');
disp(' ');
disp('  Help is available: use the command "<a href="matlab:doc AETNA">doc AETNA</a>"');
disp('  ')

% Illustralab initialization
% addpath (['C:\Documents and Settings\pkrysl\My Documents\Matlab_folder\Illustralab'], sep);
Illustralab_init;

return;

function add_subdirs_to_path(d, sep)
dl=dir(d);
for i=1:length(dl)
    if (dl(i).isdir)
        if      (~strcmp(dl(i).name,'.')) & ...
                (~strcmp(dl(i).name,'..')) & ...
                (~strcmp(dl(i).name,'CVS')) & ...
                (~strcmp(dl(i).name,'cvs')) & ...
                (~strcmp(dl(i).name,'profile')) & ...
                (~strcmp(dl(i).name(1),'@'))
            addpath([d sep dl(i).name])
            add_subdirs_to_path([d sep dl(i).name], sep);
        end
    end
end
return;



