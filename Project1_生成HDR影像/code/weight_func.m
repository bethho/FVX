function [w] = weight_func(intensity)
% the range of intensity is 0~255
    mid = (0+255)/2;
    if intensity < mid
        w = intensity;
    else
        w = 255-intensity;
    end
    