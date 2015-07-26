% Collects points by scanning a curve in a graph image.
%
% function xy = scan_on_image(image_name,x_range,y_range)
%
function xy = scan_on_image(image_name,x_range,y_range)
    img = imread(image_name);
    x_size = size(img, 2);
    y_size = size(img, 1);
    image(img,'CDataMapping','scaled');
    axis image ij;
    grid on;
    hold on
    xy = [];
    n = 0;
    % Loop, picking up the points.
    disp('Left mouse button picks points.')
    disp('Right mouse button picks last point.')
    but = 1;
    while true
        [xi,yi,but] = ginput(1);
        xi,yi
        if but ~= 1
            break;
        else
            plot(xi,yi,'ro')
            n = n+1;
            xy(:,n) = [xi;yi];
        end
    end
    %y'
    xy= [min(x_range)+xy(1,:)'/x_size*abs(x_range(2)-x_range(1)) ...
        min(y_range)+ (y_size-xy(2,:)')/y_size*abs(y_range(1)-y_range(2))];
end
