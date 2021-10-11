function [ A , m ] = alignment( OR,OC )
%align Compared image with Reference image
%OR is reference image,OC is compared image
%input and output image are all RGB image
R = rgb2gray(OR);
C = rgb2gray(OC);

move = [0 0];

for i=8:-1:1   %i is level
    
P_R = imresize(R,(0.5)^(i-1));
P_C = imresize(C,(0.5)^(i-1));
[r,c] = size(P_R);
T_P_R = median(P_R(:));
B_P_R = P_R > T_P_R;
m_P_R = ones(r,c);
m_P_R(P_R<=(T_P_R+4) & P_R>=(T_P_R-4)) = 0;
T_P_C = median(P_C(:));
B_P_C = P_C > T_P_C;
m_P_C = ones(r,c);
m_P_C(P_C<=(T_P_C+4) & P_C>=(T_P_C-4)) = 0;

NewMove = level(B_P_R , B_P_C , m_P_R , m_P_C , move);

if i == 1
    move = move + NewMove;
else 
    move = (move + NewMove)*2;
end
end

% translate original RGB image with accumulated x y tramslations which are
% stored in move as a vector
row = size(OC,1);
col = size(OC,2);
m = ones(row,col);

if move(1) > 0
   u = move(1);
   add1 = OC(:,(u+1):col,:);
   OC(:,1:(col-u),:) = add1;
   OC(:,(col-u+1):col,:) = 0;
   m(:,(col-u+1):col,:) = 0;
end
if move(1) < 0
   u = abs(move(1));
   add1 = OC(:,1:(col-u),:);
   OC(:,(u+1):col,:) = add1;
   OC(:,1:u,:) = 0;
   m(:,1:u,:) = 0;
end
if move(2) > 0
   v = move(2);
   add2 = OC((v+1):row,:,:);
   OC(1:(row-v),:,:) = add2;
   OC((row-v+1):row,:,:) = 0;
   m((row-v+1):row,:,:) = 0;
end
if move(2) < 0
    v = abs(move(2));
    add2 = OC(1:(row-v),:,:);
    OC((v+1):row,:,:) = add2;
    OC(1:v,:,:) = 0;
    m(1:v,:,:) = 0;
end

A = OC;

end

% [R1,R2,R3,R4] = pyramid(R);
% [C1,C2,C3,C4] = pyramid(C);
% 
% [r1,c1] = size(R1);
% [r2,c2] = size(R2);
% [r3,c3] = size(R3);
% [r4,c4] = size(R4);
% 
% %covert to binary image with mwdian value and generate mask
% %level 1
% T_R1 = median(R1(:));
% B_R1 = R1>T_R1;
% m_R1 = ones(r1,c1);
% m_R1(R1<=(T_R1+4) & R1>=(T_R1-4)) = 0;
% T_C1  = median(C1(:));
% B_C1 = C1>T_C1 ;
% m_C1 = ones(r1,c1);
% m_C1(C1<=(T_C1 +4) & C1>=(T_C1 -4)) = 0;
% %level 2
% T_R2 = median(R2(:));
% B_R2 = R2>T_R2;
% m_R2 = ones(r2,c2);
% m_R2(R2<=(T_R2+4) & R2>=(T_R2-4)) = 0;
% T_C2  = median(C2(:));
% B_C2 = C2>T_C2 ;
% m_C2 = ones(r2,c2);
% m_C2(C2<=(T_C2 +4) & C2>=(T_C2 -4)) = 0;
% %lecel 3 
% T_R3 = median(R3(:));
% B_R3 = R3>T_R3;
% m_R3 = ones(r3,c3);
% m_R3(R3<=(T_R3+4) & R3>=(T_R3-4)) = 0;
% T_C3  = median(C3(:));
% B_C3 = C3>T_C3 ;
% m_C3 = ones(r3,c3);
% m_C3(C3<=(T_C3 +4) & C3>=(T_C3 -4)) = 0;
% %level 4
% T_R4 = median(R4(:));
% B_R4 = R4>T_R4;
% m_R4 = ones(r4,c4);
% m_R4(R4<=(T_R4+4) & R4>=(T_R4-4)) = 0;
% T_C4  = median(C4(:));
% B_C4 = C4>T_C4 ;
% m_C4 = ones(r4,c4);
% m_C4(C4<=(T_C4 +4) & C4>=(T_C4 -4)) = 0;



% %做level 4 的移動
% type = direction(B_C4 , m_C4 , B_R4 , m_R4 , r4 , c4);
% switch type
%     case 2   %up
%         B_C3(1:2,:) = [];   %B_C3上移2步
%         m_C3(1:2,:) = [];   %m_C3切成相對應大小   
%         B_R3(r3-1:r3,:) = []; %Reference image切成相對應大小
%         m_R3(r3-1:r3,:) = [];
%         B_C2(1:4,:) = [];     %B_C2上移4步
%         m_C2(1:4,:) = [];     %m_C2切成相對應大小 
%         B_R2(r2-3:r2,:) = []; %Reference image切成相對應大小
%         m_R2(r2-3:r2,:) = [];
%         B_C1(1:8,:) = [];     %B_C1上移8步
%         m_C1(1:8,:) = [];     %m_C1切成相對應大小
%         B_R1(r1-7:r1,:) = []; %Reference image切成相對應大小
%         m_R1(r1-7:r1,:) = [];
%         overlap = R1(9:r1,:);  %原尺寸RGB image做相對應移動，未重疊區補零
%         R1(1:r1-8,:) = overlap;
%         R1(r1-7:r1,;) = 0;
%         
%     case 3
%         add3_4 = C3(1:r3-2,:);
%         C3(3:r3,:) = add3_4;
%         C3(1:2,:) = 0;
%         add2_4 = C2(1:r3-4,:);
%         C2(5:r3,:) = add2_4;
%         C2(1:4,:) = 0;
%         add1_4 = C1(1:r3-8,:);
%         C1(9:r3,:) = add1_4;
%         C1(1:8,:) = 0;
%     case 4
%         add3_4 = C3(:,3:c3);
%         C3(:,1:c3-2) = add3_4;
%         C3(:,c3-1:c3) = 0;
%         add2_4 = C2(:,5:c3);
%         C2(:,1:c3-4) = add2_4;
%         C2(:,c3-3:c3) = 0;
%         add1_4 = C1(:,9:c3);
%         C1(:,1:c3-8) = add1_4;
%         C1(:,c3-7:c3) = 0;
%     case 5 
%         add3_4 = C3(:,1:c3-2);
%         C3(:,3:c3) = add3_4;
%         C3(:,1:2) = 0;
%         add2_4 = C2(:,1:c3-4);
%         C2(:,5:c3) = add2_4;
%         C2(:,1:4) = 0;
%         add1_4 = C2(:,1:c3-4);
%         C2(:,5:c3) = add1_4;
%         C2(:,1:4) = 0;
        


