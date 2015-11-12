% Convert a number to bits as a string
%
% % s=num2bins(x)
%
% Example:
% num2bins(uint64(intmax('uint64')))
% ans =
% 1111111111111111111111111111111111111111111111111111111111111111
% num2bins(uint64(intmax('uint64')-1))
% ans =
% 1111111111111111111111111111111111111111111111111111111111111110
%
% Example:
% for  j =127:-1:-128
%     disp([num2str(j),': ',num2bins(int8(j))])
% end
% 127: 01111111
% 126: 01111110
% ...
% 2: 00000010
% 1: 00000001
% 0: 00000000
% -1: 11111111
% -2: 11111110
% -3: 11111101
% ...
% -127: 10000001
% -128: 10000000

function s=num2bins(x)
switch class(x)
    case 'double'
        Frm='%bx';
    case 'float'
        Frm='%bx';
    case {'uint8','uint16','uint32','uint64'}
        Frm='%x';
    otherwise % signed integers needs to be handled specially
        if (x>=0)
            Sign=+1; x=eval(['u',class(x),'(x)']);
        else
            Sign=-1; x=eval(['u',class(x),'(-double(x))']); x=x-1;
        end
        Frm='%x';
        shx=sprintf(Frm,x);
        s=[];
        for   j=1:length(shx)
            bits=hexbits(shx(j));
            s=[s,bits];
        end
        nbit=sscanf(class(x),'uint%d');
        if (length(s)<nbit) % Do we need to pad with zeros in front?
            s=[repmat('0',1,nbit-length(s)),s];
        end
        if (Sign<0)% for negative integer we need to do twos-complement
            s=strrep(strrep(strrep(s,'0','X'),'1','0'),'X','1');
        end
        return
end
shx=sprintf(Frm,x);
s=[];
for   j=1:length(shx)
    bits=hexbits(shx(j));
    s=[s,bits];
end

function bits=hexbits(h);
    if     (h=='0')
        bits='0000';
    elseif (h=='1')
        bits='0001';
    elseif (h=='2')
        bits='0010';
    elseif (h=='3')
        bits='0011';
    elseif (h=='4')
        bits='0100';
    elseif (h=='5')
        bits='0101';
    elseif (h=='6')
        bits='0110';
    elseif (h=='7')
        bits='0111';
    elseif (h=='8')
        bits='1000';
    elseif (h=='9')
        bits='1001';
    elseif (h=='a')
        bits='1010';
    elseif (h=='b')
        bits='1011';
    elseif (h=='c')
        bits='1100';
    elseif (h=='d')
        bits='1101';
    elseif (h=='e')
        bits='1110';
    elseif (h=='f')
        bits='1111';
    end
end
end

