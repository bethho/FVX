function [img] = equirec2cylind(Irgb, f)
    Irgb = double(Irgb);
    [size_h, size_w, ~] = size(Irgb);
    img = zeros(size(Irgb));
    thi = atan(size_w/2/f)*f;
    h = size_h;
    [x, y] = meshgrid(1:size_w,1:size_h);
    thi_x = (x/size_w-0.5)*2*thi;
    h_y = (y/size_h-0.5)*h;
    x_i = tan(thi_x/f).*f;
    y_i = size_h/2 + (h_y./f).*(x_i.^2+f^2).^0.5;
    x_i_shift = 0.5*size_w + x_i;
    for kk = 1:3
        img(:,:,kk) = interp2(x,y,double(Irgb(:,:,kk)),x_i_shift,y_i);
    end
    img = uint8(img);
end
    
    