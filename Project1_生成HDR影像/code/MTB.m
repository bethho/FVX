function [ C ] = MTB( I1,I2,I3,I4,I5,I6,I7,I8,I9 )
%aligne I2,I3,I4,I5,I6,I7,I8,I9 image to I1 image
C = cell(9,2);
C{1,1} = I1; %I1 is reference image
r = size(I1,1);
c = size(I1,2);
m1 = ones(r,c);
C{1,2} = m1;
[C{2,1},C{2,2}] = alignment(I1,I2);
[C{3,1},C{3,2}] = alignment(I1,I3);
[C{4,1},C{4,2}] = alignment(I1,I4);
[C{5,1},C{5,2}] = alignment(I1,I5);
[C{6,1},C{6,2}] = alignment(I1,I6);
[C{7,1},C{7,2}] = alignment(I1,I7);
[C{8,1},C{8,2}] = alignment(I1,I8);
[C{9,1},C{9,2}] = alignment(I1,I9);

end

