% Typeset some text from the clipboard into a figure.
function typeset_clipboard

    c=clipboardpaste;
    name =tempname;
    fid=fopen(name,'w');
    fprintf(fid,'%s\n',c.data);
    fclose(fid);
    outfile =name;
    c = {};
    fid = fopen(outfile,'r');
    while 1
        tline = fgetl(fid);
        if ~ischar(tline), break, end
        c{end+1} =tline;
    end
    fclose(fid);
    fig=figure('Units','characters','Position', [2 5 172 32]);
    uicontrol(fig,'Style','edit','HorizontalAlignment','left',...
    'Max', 50,'Min',  3,'Units','characters','Position', [1 1 170 30],'String',c,'FontSize',16);
end
