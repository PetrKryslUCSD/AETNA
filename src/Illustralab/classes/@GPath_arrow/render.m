function p = render(p)
    color = [];
    if ~isempty(p.GPath.color)
        color =p.GPath.color;
    end
    arrowstyle = [];
    if ~isempty(p.arrowstyle)
        arrowstyle =p.arrowstyle;
    end
    arrowaspect = 2;
    if ~isempty(p.arrowaspect)
        arrowaspect =p.arrowaspect;
    end
    arrowsize = 0.1;
    if ~isempty(p.arrowsize)
        arrowsize =p.arrowsize;
    end
    if ~isempty(color)
        if (~isempty(arrowstyle)) && strcmp(arrowstyle,'triangle')
            if p.followorientation 
                anchor =p.GPath.anchor;
                triangle_arrow(anchor(:,1),anchor(:,2), arrowsize,arrowsize/arrowaspect, color);
            end
        end
        if (~isempty(arrowstyle)) && strcmp(arrowstyle,'reversed_triangle')
            if p.followorientation 
                anchor =p.GPath.anchor;
                anchor(1,:) =2*anchor(2,:)-anchor(1,:);
                triangle_arrow(anchor(:,1),anchor(:,2),arrowsize,arrowsize/arrowaspect, color);
            end
        end
    end
end

function triangle_arrow(X,Y, c,d, color)
    % c Is the length of the arrow
    % d Is the width of the arrow at the base
    VEC1 = [X(end) - X(end-1), Y(end) - Y(end-1)];
    L    = norm(VEC1);
    VEC1 = VEC1/L;
    VEC2 = [-VEC1(2),VEC1(1)];
    SPITZE = [X(end), Y(end)];
    ENDE1 = SPITZE - c*VEC1 + d*VEC2/2;
    ENDE2 = SPITZE - c*VEC1 - d*VEC2/2;
    Z = [SPITZE; ENDE1;ENDE2;SPITZE];
    h=fill(Z(:,1),Z(:,2), color);h= plot(Z(:,1),Z(:,2), 'Color',color);
end