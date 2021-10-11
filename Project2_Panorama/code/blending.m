function [imgab] = blending(imga,imgb,H)
    %---------input------------------------------------
    % imga = left RGB image, type = double, size=(h,2*w), range=0~255
    % imgb = right RGB image, type = double, size=(h,2*w), range=0~255
    % translate matrix (m1,m2)
    %---------output------------------------------------
    % imgab = stitch image, type = uint8, size=(h,2w)
    %---------------------------------------------------
    left_bound = size(imga,2)/2 - floor(H(1));
    right_bound = size(imga,2)/2;
    a = linspace(0,1,right_bound+1-left_bound+1);
    s1 = [ones(1,left_bound-1),1-a,zeros(1,size(imga,2)-(right_bound+1))];
    s2 = [zeros(1,left_bound-1),a,ones(1,size(imga,2)-(right_bound+1))];
    [x1,y1] = meshgrid(s1,1:1712);
    [x2,y2] = meshgrid(s2,1:1712);
    imgab = zeros(size(imga));
    for i = 1:3
        imgab(:,:,i) = imga(:,:,i).*x1 + imgb(:,:,i).*x2;
    end
    imgab = uint8(imgab);
end