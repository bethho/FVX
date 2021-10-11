function [ L,H0,H1,H2,H3,H4 ] = AllFpLo( P0,P1,P2,P3,P4 )
% compute all feature point location and corner detection function for all pyramid
%--------------input-----------------------------
% P0~P4:level 0~level 4 pramid image
%--------------output----------------------------
% H0~H4 :corner detection function of level 0~level 4 pramid
% image,matrices(same as gray image size) 
%L:location of feature point(FP) for all pyramid image(location are stored base on P0 size),
%a matrix(FP num*4),column:x(column),y(row),level(scale),corner detection funxtion(H)
%------------------------------------------------


[L0,H0] = FPLo(P0,P0);
[L1,H1] = FPLo(P1,P0);
[L2,H2] = FPLo(P2,P0);
[L3,H3] = FPLo(P3,P0);
[L4,H4] = FPLo(P4,P0);

L = [L0;L1;L2;L3;L4];

end

