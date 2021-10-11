%dir_path = 'img_data/grass';
dir_path = 'img_data/lab';
list = dir(dir_path);
f = 1750;
% I = cell(length(list)-2,1);
% for i = 3:length(list)
%     I{i-2} = imread([dir_path,'/',list(i).name]);
% end
imgab = cell(length(list)-2+1,1);
H = cell(length(list)-2+1,1);
imgs = [];
for i = 1:length(imgab)
    if i < length(H)
        I1 = imread([dir_path,'/',list(i+2).name]);
        I2 = imread([dir_path,'/',list(i+3).name]);
        [imgab{i}, H{i}] = stitch_img(I1,I2,f);
        imgs = [imgs(:,1:end-1712/2,:),imgab{i}(:,1712/2:end,:)];
    else
        I1 = imread([dir_path,'/',list(i+2).name]);
        I2 = imread([dir_path,'/',list(3).name]);
        [imgab{i}, H{i}] = stitch_img(I1,I2,f);
        imgs = [imgs,imgab{i}(:,1712/2:end-1712/2,:)];
    end
    figure()
    imshow(imgs)
end
imgs = [imgab{1}(:,1:end-1712/2,:),imgab{2}(:,1712/2:end-1712/2,:)];