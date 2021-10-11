function [Eij, rgb] = demo(s)
    A = cell(45,1);
    for i=1:9
    filename = frameName(s,i);
    A{i} = imread(filename);
    end

    C = MTB(A{1},A{2},A{3},A{4},A{5},A{6},A{7},A{8},A{9});
    exp_t = [1/4 ,1/8, 1/15, 1/30, 1/60, 1/125, 1/250, 1/500, 1/1000];
    num_point = 64;
    img = cell(9,1);
    mask = cell(9,1);
    for i = 1:1:9
        img{i,1} = C{i,1};
        mask{i,1} = C{i,2};
    end
    [matrix] = findpoint(img, exp_t, mask, num_point);
    num_photo = 9;
    [x, A, b] = least_square(matrix, num_photo, num_point,1);
    g = x(1:256,1,:);
    X = 0:255;
    R = fit(X',g(:,1,1),'poly2');
    G = fit(X',g(:,1,2),'poly2');
    B = fit(X',g(:,1,3),'poly2');
    gg = zeros(256,1,3);
    gg(:,1,1) = R(X');
    gg(:,1,2) = G(X');
    gg(:,1,3) = B(X');
    w = [];
    for i = 0:255
        w = [w, weight_func(i)];
    end
    [Eij] = irradiance(img, gg, w, mask, exp_t, num_photo);
    Eij(isnan(Eij)) = 0;
    rgb = tonemap(Eij);
    imshow(rgb)
    hdrwrite(Eij, 'hdr_result.hdr');
    imwrite(rgb,'hdr_tonemap.png')
end
