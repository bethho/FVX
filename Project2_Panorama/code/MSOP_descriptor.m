function [features, descriptors] = MSOP_descriptor(features, Pyramid)
    %--------------input-----------------------------
    % features: a matrix(250*3), column: x(column), y(row), scale
    % BlurPyramid: a cell(5,1), 5 level blur images
    %--------------output----------------------------
    % features: a matrix(num*3)
    % descriptor: a matrix(64*num)
    %------------------------------------------------
    level = cell(5,3);
    %% calculate orientation of blurred gradient in all level
    [h,w] = size(Pyramid{1});
    thresh = 20*(2^0.5);
    features(find(features(:,1)<= thresh | features(:,1) >= w-thresh),:) = [];
    features(find(features(:,2)<= thresh | features(:,2) >= h-thresh),:) = [];
    for i = 1:5
        [gx,gy] = imgradientxy(Pyramid{i}, 'prewitt');
        gx = imgaussfilt(gx, 4.5);
        gy = imgaussfilt(gy, 4.5);
        costhi = gx./(gx.^2+gy.^2).^0.5;
        sinthi = gx./(gx.^2+gy.^2).^0.5;
        level{i,1} = imgaussfilt(Pyramid{i}, 2);
        level{i,2} = costhi;
        level{i,3} = sinthi;
    end
    
    descriptors = zeros(64,length(features));
    for j = 1:length(features)
        [descriptor] = eachfeature(features(j,:), level(features(j,3)+1,:));
        descriptors(:,j) = descriptor;
    end
end
        
    