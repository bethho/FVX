function [descriptor] = eachfeature(feature, level)
    %-------------input---------------------------------------
    % feature: a vector(1,2) -> x, y coordinate(column, row)
    % level: the level of pyramid image, x and y coordination
    %-------------output--------------------------------------
    % descriptor = a matrix (64,num)
    %---------------------------------------------------------
    img = level{1,1};
    cos = level{1,2};
    sin = level{1,3};
    scale = feature(1,3);
    f_y = feature(1,2)/(2^scale);
    f_x = feature(1,1)/(2^scale);
    cos = cos(f_y,f_x);
    sin = sin(f_y,f_x);
    [h,w] = size(img);
    x = linspace(1,w,w);
    y = linspace(1,h,h);
    xx = linspace(-19,20,40);
    yy = linspace(-19,20,40);
    [X,Y] = meshgrid(x,y);
    [XX,YY] = meshgrid(xx,yy);
    X = X-f_x;
    Y = Y-f_y;
    X_new = cos*XX+sin*YY;
    Y_new = -sin*XX+cos*YY;
    img_rot = interp2(X,Y,double(img),X_new,Y_new);
    descriptor = [];
    % the order od descriptor is left to right and up to down
    for i = 1:8
        for j = 1:8
            descriptor = [descriptor;img_rot(i*5-2,j*5-2)];
        end
    end
    descriptor = (descriptor - mean(descriptor))/std(descriptor);
end
    
            
            
    
     