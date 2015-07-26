function highlight_clipboard

    c=clipboardpaste;
    name =tempname;
    fid=fopen(name,'w');
    fprintf(fid,'%s\n',c.data);
    fclose(fid);
    outfile =tempname;
    highlight(name,'latex',outfile);
    c = {};
    fid = fopen(outfile,'r');
    while 1
        tline = fgetl(fid);
        if ~ischar(tline), break, end
        c{end+1} =tline;
    end
    fclose(fid);
    fig=figure('Position', [20 150 600 700]);
    uicontrol(fig,'Style','edit','HorizontalAlignment','left','Max', 50,'Min',  3,'Position', [1 1 600 700],'String',c);
end
