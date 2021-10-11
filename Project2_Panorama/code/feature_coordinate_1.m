function [feature_cylind] = feature_coordinate_1(features, img_size, f)
    %---------input----------------------------------------------------
    % features: [pair_X;pair_Y]
    % img_size: hiegth and width of img_size
    % f = focal length
    %--------output----------------------------------------------------
    % feature_cylind: the coordinate of features change to cylindral
    % cooordinate
    %------------------------------------------------------------------
    h = img_size(1);
    w = img_size(2);
    pair_X = features(1:2,:);
    pair_Y = features(3:4,:);
    pair_X_new = [];
    pair_Y_new = [];
    
    for i = 1:2
        thi = atan(w/2/f(i))*f(i);
        hh = h;
        x = pair_X(i,:);
        y = pair_Y(i,:);
        xx = x-w/2;
        yy = y-h/2;
        x_new = f(i)*atan(xx./f(i));
        y_new = f(i)*yy./(xx.^2+f(i).^2).^0.5;
        y_new = (y_new/hh+0.5)*h;
        x_new = (x_new./(2*thi)+0.5)*w;
        pair_X_new = [pair_X_new;x_new];
        pair_Y_new = [pair_Y_new;y_new];
    end
    feature_cylind = [pair_X_new;pair_Y_new];
end