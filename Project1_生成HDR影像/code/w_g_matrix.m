function [wij, gij] = w_g_matrix(img, g, w, mask)
    %% input
    % img = R or G or B channel
    % g = g(Zij)
    % w = weight function
    %% output
    % wij = weight of pixel in the img
    % gij = g of pixel in the img
    img = reshape(img, [size(img,1)*size(img,2), 1]);
    wij = reshape(w(img+1), [size(mask,1), size(mask,2)]).*mask;
    gij = reshape(g(img+1), [size(mask,1), size(mask,2)]);
end
    