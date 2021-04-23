% Array spreadsheet-like viewer.
%
% function fig = ars6(a,varargin);
%
% It takes the array and the name for the array that should be displayed in
% the spreadsheet as a heading.
% 
% (C) 2004, Petr Krysl
% Last change: 01/04/05
function fig = ars6(a,varargin);
%
if nargin > 1
    name=varargin{1};
else
    name=inputname (1);
    if isempty (name)
        name ='anon?';
    end
end
xy=[];
maxcol=6;
maxrow=12;
butwidth= 1.0;
if nargin > 2
    options=varargin{2};
    if isfield(options,'xy')
        xy= options.xy;
    end
    if isfield(options,'maxcol')
        maxcol= options.maxcol;
    end
    if isfield(options,'maxrow')
        maxrow= options.maxrow;
    end
    if (~isstruct(options))  && (strcmp(options,'natural'))
        [nrows,ncols] = size(a);
        maxcol= ncols;
        maxrow= nrows;
    end
    if isfield(options,'butwidth')
        butwidth= options.butwidth;
    end
end
[nrows,ncols] = size(a);
ftSize=get(0,'DefaultUIControlFontSize');
bw=round (butwidth*100*ftSize/11);
bh=1.8*ftSize;
bd_size = 2; %border size
fcbw=round (min(3*bw,max(bw,17*ftSize/11*length (name))));
scSize=get(0,'ScreenSize');
need_hslider=(ncols>maxcol);
need_vslider=(nrows>maxrow);
fw = fcbw+bd_size+(min(ncols,maxcol))*(bw+bd_size)+bd_size;
hss=0;
vss=0;
if need_vslider
    vss=bh+bd_size; fw=fw+vss;
end
fh = bh+bd_size+(min(nrows,maxrow))*(bh+bd_size)+bd_size;
if need_hslider
    hss=bh+bd_size; fh=fh+hss;
end

if isempty(xy)
    xy =[scSize(3)/16 scSize(4)/4];
end
% I am returning the figure handle, so that all of the spreadsheets
% can be closed when the invoker is closed.
fig=figure('unit','pixels','NumberTitle','off','Menubar','none','resize','off',...
    'Name','ars6 (C) 2004-2007,Petr Krysl','position', [xy(1) xy(2) fw fh]);

posy = fh-bh-bd_size;
posx = vss+bd_size;
posxb = posx;
uicontrol('Parent', fig,'Style','text','unit','pixels','position', [posx posy fcbw bh],...
    'String',name,'BackgroundColor',[0.9 0.9 0.6],...
    'FontSize',ftSize,'FontName','default','FontWeight','bold');
colabels={};
for j = 1:(min(ncols,maxcol))
    colabels{end+1}=uicontrol('Parent', fig,'Style','text','unit','pixels',...
        'position', [posx+fcbw+bd_size posy bw bh],...
        'FontSize',ftSize,'FontName','default','String',num2str(j));
    posx = posx+bw+bd_size;
end

posy = posy-bh-bd_size;
posx = vss+bd_size;
posxb = posx;
rolabels={};
dalabels=cell((min(nrows,maxrow)),(min(ncols,maxcol)));
for i = 1:(min(nrows,maxrow))
    rolabels{end+1}=uicontrol('Parent', fig,'Style','text','unit','pixels',...
        'position', [posx posy fcbw bh],'FontSize',ftSize,'FontName','default',...
        'String',num2str(i));
    for j = 1:(min(ncols,maxcol))
        try
            dalabels{i,j}=uicontrol('Parent', fig,'Style','text','unit','pixels',...
                'position', [posx+fcbw+bd_size posy bw bh],'BackgroundColor',[1 1 1],...
                'FontSize',ftSize,'FontName','default','String',o2str(a(i,j)));
        catch
            dalabels{i,j}=uicontrol('Parent', fig,'Style','text','unit','pixels',...
                'position', [posx+fcbw+bd_size posy bw bh],'BackgroundColor',[1 1 1],...
                'FontSize',ftSize,'FontName','default','String',char(a));
        end
        posx = posx+bw+bd_size;
    end
    posx = posxb;
    posy = posy-bh-bd_size;
end

set(fig,'UserData',struct('fig',fig,'nrows',nrows,'ncols',ncols,...
    'maxrow',maxrow,'maxcol',maxcol,...
    'dalabels',{dalabels},'colabels',{colabels},'rolabels',{rolabels},...
    'a',a,'col',1,'row',1));
if need_hslider
    uicontrol('Parent', fig,'Style','slider','Min',0,'Max',ncols-maxcol,'Value',0,'position', [vss 0 fw-vss bh],...
        'SliderStep',[0.01 0.2],'Callback', @slide_panel_horizontally);
end
if need_vslider
    uicontrol('Parent', fig,'Style','slider','Min',-(nrows-maxrow),'Max',0,'Value',0,'position', [0 hss bh fh-hss],...
        'SliderStep',[0.01 0.2],'Callback', @slide_panel_vertically);
end

return;

function s=o2str(o)
    c=class(o);
    if strcmp(c,'function_handle')
        s=func2str(o);
    elseif strcmp(c,'cell')
        s=c;
    elseif strcmp(c,'struct')
        s=c;
    else
        s=num2str(o);
    end
    return;

function slide_panel_horizontally(h,varargin)
fig=get (h,'Parent');
s=get(fig,'UserData');
v=get(h,'Value');
s.col=min(s.ncols-s.maxcol+1,round(v)+1);
for j = 1:(min(s.ncols,s.maxcol))
    set(s.colabels{j},'String',num2str(s.col+j-1));
end
for i = 1:(min(s.nrows,s.maxrow))
    set(s.rolabels{i},'String',num2str(s.row+i-1));
    for j = 1:(min(s.ncols,s.maxcol))
        set(s.dalabels{i,j},'String',num2str(s.a(s.row+i-1,s.col+j-1)));
    end
end
set(fig,'UserData', s);
return;

function slide_panel_vertically(h,varargin)
fig=get (h,'Parent');
s=get(fig,'UserData');
v=get(h,'Value');
s.row=min((s.nrows-s.maxrow)+1,-round(v)+1);
for j = 1:(min(s.ncols,s.maxcol))
    set(s.colabels{j},'String',num2str(s.col+j-1));
end
for i = 1:(min(s.nrows,s.maxrow))
    set(s.rolabels{i},'String',num2str(s.row+i-1));
    for j = 1:(min(s.ncols,s.maxcol))
        set(s.dalabels{i,j},'String',num2str(s.a(s.row+i-1,s.col+j-1)));
    end
end
set(fig,'UserData', s);
return;
