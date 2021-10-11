function [matrix] = choose_point(im, index)
    matrix = zeros(length(index),1,3);
    for i = 1:1:3       
        A = im(:,:,i);
        matrix(:,:,i) = A(index);
    end
end
            