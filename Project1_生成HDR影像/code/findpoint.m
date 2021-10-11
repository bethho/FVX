function [matrix] = findpoint(img, exp_t, mask, num_point)
    %% input
    % img = a set of rgb image
    % exp_t = exposure time
    % mask = a set f mask
    % num_point = choose number of point
    %% output
    % matrix = [num_photo*num_point,2]
    
    % exp_t vector
    b = [];
    num_photo = size(img,1);
    for i = 1:1:num_photo
        b = [b; ones(num_point,1,3)*exp_t(i)];
    end
    
    index = 1:1:size(img{1},1)*size(img{1},2);
    M = zeros(size(img{1},1),size(img{1},2),num_photo);
    for i = 1:1:num_photo
        M(:,:,i) = mask{i};
    end
    s = sum(M,3);
    id = find(s ~= num_photo);
    index(id) = [];
    index_rand = index(randperm(length(index)));
    d = num_point;
    MM = [];
    while size(MM,1) < num_point
        M = zeros(d,num_photo, 3);
        for i = 1:1:num_photo
            M(:,i,:) = choose_point(img{i}, index_rand(1:d));
        end
        rm = [];
        for i = 1:1:d
            A = M(i,:,:);
            if min(A(:)) < 2
                rm = [rm,i];
            end
            if max(A(:)) > 253
                rm = [rm,i];
            end
        end
        index_rand(1:d) = [];
        M(rm,:,:) = [];
        MM = [MM;M];
        d = num_point - size(MM,1);
        
    end
    matrix = [];
    for i = 1:1:num_photo
        matrix = [matrix; MM(:,i,:)];
    end
    matrix = [matrix, b];
    size(matrix)
end
                
        
    
    
    