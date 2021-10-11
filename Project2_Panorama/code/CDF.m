function [ H ] = CDF( I )
% compute corner detection function of image 
%--------------input-----------------------------
% I:input grayscle image 
%--------------output----------------------------
% H:corner detection function  of whole image(same as image size)
%------------------------------------------------



[gx,gy] = imgradientxy(I,'prewitt');
gx = imgaussfilt(gx,1);
gy = imgaussfilt(gy,1);
gx2 = gx.^2;
gy2 = gy.^2;
gxy = gx.*gy;
gx2 = imgaussfilt(gx2,1.5);
gy2 = imgaussfilt(gy2,1.5);
gxy = imgaussfilt(gxy,1.5);

H = ((gx2.*gy2)-(gxy.^2))./(gx2+gy2);
H(isnan(H)) = 0;

H = abs(H);

end

