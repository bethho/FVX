 function [ ch ] = ANMS( L )
% distrbute feature points uniformly
%--------------input-----------------------------
% L:location of feature point(FP),a matrix(FPnum*4)
%,column:x(column),y(row),level(scale),corner detection funxtion(H)
%--------------output----------------------------
% ch :uniformly distributed feature point,a matrix(250*3),column:x(column),y(row),level(scale)
%------------------------------------------------

%frst point chosen in final 250 FP
[~,m1] = max(L(:,4));
ch = [];
a = L(m1,1:3);
ch = [ch;a];
% find next FP
L(m1,:) = [];
D = sqrt((L(:,1)-ch(1,1)).^2 + (L(:,2)-ch(1,2)).^2);
D(:,2) = L(:,4);
mr = max(D(:,1));
mr = fix(mr);
[m3,mr] = NextMax(D,mr);
%second point chosen in final 250 FP
a = L(m3,1:3);
ch = [ch;a];
[r1,~] = size(ch);
count = 2;

while r1 ~= 250
  L(m3,:) = [];
  D(m3,:) = [];
  D2 = D(:,1);
  D1 = sqrt((L(:,1)-ch(count,1)).^2 + (L(:,2)-ch(count,2)).^2);
  D = [D1 D2];
  D = min(D,[],2);
  D(:,2) = L(:,4);
  [m3,mr] = NextMax(D,mr);
  a = L(m3,1:3);
  ch = [ch;a];
  [r1,~] = size(ch);
  count = count+1;
end



end

