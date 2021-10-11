function [imgab, H] = stitch_img(I1,I2,f)
    %---------input------------------------------------
    % I1 = left RGB image, type = uint8, size=(h,w), range=0~255
    % I2 = right RGB image, type = uint8, size=(h,w), range=0~255
    %---------output------------------------------------
    % imgab = stitch image, type = uint8, size=(h,2w)
    % translate matrix (m1,m2)
    %---------------------------------------------------
    %I1 = double(I1);
    %I2 = double(I2);
    I0 = zeros(size(I1));
    [ P0,P1,P2,P3,P4 ] = BlurPyramid(I1);
    [ L,H0,H1,H2,H3,H4 ]= AllFpLo(P0,P1,P2,P3,P4);
    ch = ANMS( L );
    Py = {P0;P1;P2;P3;P4};
    [ PP0,PP1,PP2,PP3,PP4 ] = BlurPyramid(I2);
    [ L2,HH0,HH1,HH2,HH3,HH4 ]= AllFpLo(PP0,PP1,PP2,PP3,PP4);
    ch2 = ANMS( L2 );
    Py2 = {PP0;PP1;PP2;PP3;PP4};
    %% 去除outlier
    ch(find(ch(:,1)<= size(I1,2)/2),:) = [];
    ch2(find(ch2(:,1)>= size(I1,2)/2),:) = [];
    %% descriptor
    [fp1,des1] = MSOP_descriptor(ch,Py);
    [fp2,des2] = MSOP_descriptor(ch2,Py2);
    [ X,Y ] = matching( des1,des2,fp1,fp2 );

    %% 去除outlier
    d = abs((Y(1,:)-Y(2,:))./(X(1,:)-X(2,:)-size(I1,2)))>0.5;
    X(:,d)=[];
    Y(:,d)=[];
    %% coordination change
    %f = 1750;
    [img] = equirec2cylind(I1, f);
    [img2] = equirec2cylind(I2, f);
    size_1 = size(I2);
    [feature_cylind] = feature_coordinate_1([X;Y], size_1, [f,f]);
    feature_cylind(2,:) = feature_cylind(2,:)+size(I1,2);
    [XX1,YY1,H] = RANSAC(feature_cylind(1:2,:),feature_cylind(3:4,:), 100, 9);

    imga = double([img,I0]);
    imgb = double([I0,img2]);
    [x, y] = meshgrid(1:size(imga,2),1:size(imga,1));
    xx = x+H(1);
    yy = y+H(2);
    img3 = zeros(size(imgb));
    for kk = 1:3
        img3(:,:,kk) = interp2(x,y,double(imgb(:,:,kk)),xx,yy);
    end
    [imgab] = blending(imga,img3,H);
    imgab = imgab(:,1:size(imgab,2)-H(1),:);
end
    
    