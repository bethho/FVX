function [ P0,P1,P2,P3,P4 ] = BlurPyramid(I)
%blur image at this level and scale the smooth image (by factor 0.5) to
% creat image at next level
%--------------input-----------------------------
% I:RGB image 
%--------------output----------------------------
%P0 P1 P2 P3 P4:output pyramid image,P0 is biggest  and P4 is smallest

I_g = rgb2gray(I);
P0 = I_g;
gau1 = imgaussfilt(P0,1);
P1 = imresize(gau1,0.5);
gau2 = imgaussfilt(P1,1);
P2 = imresize(gau2,0.5);
gau3 = imgaussfilt(P2,1);
P3 = imresize(gau3,0.5);
gau4 = imgaussfilt(P3,1);
P4 = imresize(gau4,0.5);

end

