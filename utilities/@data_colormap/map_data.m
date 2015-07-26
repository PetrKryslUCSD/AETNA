% Map data values to color.
%
% function color = map_data (self, v)
%
% v= data value
% 
% Call as:
% c=field(struct ('name', ['c'], 'data', map_data(dcm, Uz)));
% The field c ('colorfield') may then be passed to graphic drawing primitives.
% 
function color = map_data (self, v)
    n = length(v);
    color = zeros(n,3);
    if (self.rmax > self.rmin)
        nc=size(self.colormap,1);
        for i = 1:n
            k = fix(((v(i)-self.rmin)/(self.rmax-self.rmin))*(self.ncolors-1))+1;
            if (k >= 1) && (k<=nc)
                color(i,:) = self.colormap(k,:);
            else
                if (k < 1) && (k<=size(colormap,1))
                    color(i,:) = self.colormap(1,:);
                else % k>size(colormap,1)
                    color(i,:) = self.colormap(end,:);
                end
            end
        end
        if (sum(color(i,:))==3)
            disp(' here')
        end
    end
    return;
end
