function Arrowobject  =arrow(anchor, components, context)
% Draw an arrow
%
% function arrow(self, components, direction, context)
%
% required arguments:
% anchor= coordinate of the anchor point;
% components= vector representing the arrow
% context = struct with following optional fields
%    color = color if polygons should be drawn in solid color,
%    tessel = number of polygons along the circumference;
%    fill=string: either 'none' or 'interp' or 'flat'
%
if (~exist('context','var' ))
    context.color=[0,0,0];
end

color ='black';
if isfield(context,'color')
    color = context.color;
end
dim=length(anchor);
if dim<3
    anchor(end+1)=0; components(end+1)=0;
end
if dim<2
    anchor(end+1)=0; components(end+1)=0;
end
anchor=reshape(anchor,3,1);
components=reshape(components,3,1);
c1=anchor; c2=anchor+components;
if (isfield(context,'cheap_arrow'))&&context.cheap_arrow
    context.edgecolor =color;
    draw_polyline(self,  [c1';c2'], [1, 2], context);
    return;
end

dn=norm(components);
if isfield(context,'tessel')
    tessel= context.tessel;
else
    tessel= 9;
end
shaft_radius_fraction =1/40;
if isfield(context,'shaft_radius_fraction')
    shaft_radius_fraction= context.shaft_radius_fraction;
end
shaft_radius=dn*shaft_radius_fraction;
head_radius_fraction =1/13;
if isfield(context,'head_radius_fraction')
    head_radius_fraction= context.head_radius_fraction;
end
head_radius=dn*head_radius_fraction;
[x,y,z]=cylinder([shaft_radius,shaft_radius,head_radius,0],tessel);
head_to_shaft_fraction = 0.5;
if isfield(context,'head_to_shaft_fraction')
    head_to_shaft_fraction= context.head_to_shaft_fraction;
end
if (head_to_shaft_fraction<0)
    head_to_shaft_fraction=0.009;
end
z(2,:)=(1-head_to_shaft_fraction);%z(3,:);
z(3,:)=z(2,:);
z=z*norm(c2-c1);
p=surf2patch(x,y,z);
p.vertices=[p.vertices(:,1)  p.vertices(:,2)  p.vertices(:,3)];
T=transf(c1,c2);
p.vertices = p.vertices * T';
p.vertices=[p.vertices(:,1) + c1(1) ...
    p.vertices(:,2) + c1(2) ...
    p.vertices(:,3) + c1(3)];
if isfield(context,'length_units')
    p.vertices=p.vertices/context.length_units;
end
Arrowobject =patch('Vertices',p.vertices,'Faces',p.faces,'FaceColor',color,'EdgeColor','none');
return;

    function T=transf(c1,c2)
        a=(c2-c1);
        if norm(a) > 0
            a=a/norm(a);
            b=a*0; b(3)=1;
            if abs(abs(dot(a,b))-1) < 1e-6
                if (dot(a,b)>0)
                    T=eye(3);
                else
                    T=[1,0,0;0,-1,0;0,0,-1];
                end
                return;
            end
            A=skewmat(a);
            c=A*b;
            c=c/norm(c);
            b=skewmat(c)*a;
            T=[b c a]; % note: cylinder() constructs it w/ axis parallel to the Z-axis!
        else
            T=eye(3,3);
        end
    end
end