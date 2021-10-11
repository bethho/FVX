function [x, A, b] = least_square(matrix, num_photo, num_point, la)
    %% define input
    % p = num_photo
    % n = interesting point in each photo
    % matrix(n*p, 2) = intensity and exposure_time of each point in each photo
    % num_photo = number of photo
    %% define ouput
    % x(256+p, 1) = combine gi and ln(Ei)

    %% procedure
    [n_p,~] = size(matrix);
    x = zeros(256+num_point,1,3);
    for j = 1:1:3
        n = num_point; %interesting point in each photo
        % gi - ln(Ei) = ln(exposure_time
        A = zeros(n_p,256);
        I = repmat(-eye(n),[num_photo,1]);
        b = zeros(n_p,1);
        for i = 1:n_p
            intensity = matrix(i,1,j); % range 0~255
            exposure_time = log(matrix(i,2,j));
            A(i,intensity+1) = weight_func(intensity);
            b(i,1) = exposure_time*weight_func(intensity);
            I(i,:) = I(i,:)*weight_func(intensity);
        end
        AA = zeros(1,256+n);
        AA(1,128+1) = 1;
        A = [A,I;AA];
        % gi'' = 0 (smooth term)
        AA = zeros(254,256+n);
        bb = zeros(254+1,1);
        for i = 1:254
            AA(i,i) = 1*weight_func(i);
            AA(i,i+1) = -2*weight_func(i);
            AA(i,i+2) = 1*weight_func(i);
        end
        A = [A;la*AA];
        b = [b;bb];
        x(:,1,j) = pinv(A)*b;
    end
    
end
    