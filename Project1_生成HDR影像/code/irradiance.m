function [Eij] = irradiance(img, g, w, mask, exp_t, num_photo)
    %% input
    % img = num_photo RGB images
    % g = g(z)
    % w = output vector of weight function
    % mask = shift image
    % num_photo = number of photo
    %% output
    % Eij = irradiance
    Eij = zeros(size(img{1},1),size(img{1},2),3);
    for i = 1:1:3
        wij = zeros(size(img{1},1),size(img{1},2),num_photo);
        gij = zeros(size(img{1},1),size(img{1},2),num_photo);
        for j = 1:1:num_photo
            image = img{j};
            [wij(:,:,j), gij(:,:,j)] = w_g_matrix(image(:,:,i), g(:,1,i), w, mask{j});
            gij(:,:,j) = gij(:,:,j)-log(exp_t(j));
        end
        A = wij.*gij;
        lnEij = sum(A, 3)./sum(wij, 3);
        Eij(:,:,i) = exp(lnEij);
    end
end