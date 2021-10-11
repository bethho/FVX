I= imread('img_data/P1250034.JPG');
I2 = imread('img_data/P1250035.JPG');
[imgab, H] = stitch_img(I,I2,1750);
I0 = zeros(size(I));
[ P0,P1,P2,P3,P4 ] = BlurPyramid(I);
[ L,H0,H1,H2,H3,H4 ]= AllFpLo(P0,P1,P2,P3,P4);
ch = ANMS( L );
Py = {P0;P1;P2;P3;P4};


[ PP0,PP1,PP2,PP3,PP4 ] = BlurPyramid(I2);
[ L2,HH0,HH1,HH2,HH3,HH4 ]= AllFpLo(PP0,PP1,PP2,PP3,PP4);
ch2 = ANMS( L2 );
Py2 = {PP0;PP1;PP2;PP3;PP4};
%% 去除outlier
ch(find(ch(:,1)<= size(I,2)/2),:) = [];
ch2(find(ch2(:,1)>= size(I,2)/2),:) = [];
%% descriptor
[fp1,des1] = MSOP_descriptor(ch,Py);
[fp2,des2] = MSOP_descriptor(ch2,Py2);
[ X,Y ] = matching( des1,des2,fp1,fp2 );

%% 去除outlier
d = abs((Y(1,:)-Y(2,:))./(X(1,:)-X(2,:)-size(I,2)))>0.5;
X(:,d)=[];
Y(:,d)=[];
%% coordination change
f = 1750;
[img] = equirec2cylind(I, f);
[img2] = equirec2cylind(I2, f);
size_1 = size(I2);
[feature_cylind] = feature_coordinate_1([X;Y], size_1, [f,f]);
feature_cylind(2,:) = feature_cylind(2,:)+size(I,2);
[XX1,YY1,H] = RANSAC(feature_cylind(1:2,:),feature_cylind(3:4,:), 6, 9);

imga = [img,I0];
imgb = [I0,img2];
[x, y] = meshgrid(1:size(imga,2),1:size(imga,1));
xx = x+H(1);
yy = y+H(2);
img3 = zeros(size(imgb));
for kk = 1:3
    img3(:,:,kk) = interp2(x,y,double(imgb(:,:,kk)),xx,yy);
end

%% test features
II = [I,I2];
figure
imshow(II)
hold on
plot(ch(:,1),ch(:,2),'r+')
plot(ch2(:,1)+size(I,2),ch2(:,2),'r+')
figure
imshow(II)
hold on
for i = 1:length(ch)
    line([ch(i,1),ch2(i,1)+size(I,2)],[ch(i,2),ch2(i,2)]);
end
figure
imshow(II)
hold on
for i = 1:length(X)
    line([X(1,i),X(2,i)+size(I,2)],[Y(1,i),Y(2,i)]);
end
figure
imshow(I2)
hold on
plot(X(2,:),Y(2,:),'r+')
figure
imshow(I)
hold on
plot(X(1,:),Y(1,:),'r+')

%% coordination change
f = 1750;
[img] = equirec2cylind(I, f);
[img2] = equirec2cylind(I2, f);
size_1 = size(I2);
[feature_cylind] = feature_coordinate_1([X;Y], size_1, [f,f]);
feature_cylind(2,:) = feature_cylind(2,:)+size(I,2);
[XX1,YY1,H] = RANSAC(feature_cylind(1:2,:),feature_cylind(3:4,:), 6, 9);

imga = [img,I0];
imgb = [I0,img2];
[x, y] = meshgrid(1:size(imga,2),1:size(imga,1));
xx = x+H(1);
yy = y+H(2);
img3 = zeros(size(imgb));
for kk = 1:3
    img3(:,:,kk) = interp2(x,y,double(imgb(:,:,kk)),xx,yy);
end
imgab = zeros(size(imga));
for i = 1:3
    imgab(:,:,i) = imga(:,:,i).*x1 + imgb(:,:,i).*x2;
end
figure
imshow(uint8(double(imga)*0.5+img3*0.5))
[imgab] = blending(double(imga),img3,H);
imga = double(imga);
imgb = img3;
figure
imshow(imgab)
figure
imshow(uint8(img3))


figure
imshow([img,img2])
hold on
plot(feature_cylind(1,:),feature_cylind(3,:),'r+')
plot(feature_cylind(2,:),feature_cylind(4,:),'r+')
figure
imshow([img,img2])
hold on
for i = 1:length(feature_cylind)
    line([feature_cylind(1,:),feature_cylind(2,:)],[feature_cylind(3,:),feature_cylind(4,:)]);
end
hold on
plot(XX1(1,:),YY1(1,:),'r+')
figure
imshow(img2)
hold on
plot(XX1(2,:),YY1(2,:),'r+')





