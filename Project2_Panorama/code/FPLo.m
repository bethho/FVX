function [ L,H ] = FPLo( Pn,P0 )
%--------------input-----------------------------
% P0:0 level image(highest resolution) ,Pn :any level of pyramid images
%--------------output----------------------------
% H :corner detection function of image,a matrix(same as gray image size) ,
% L:location of feature point(FP),a matrix(FPnum*4)
%,column:x(column),y(row),level(scale),corner detection funxtion(H)
%------------------------------------------------


H = CDF(Pn);
[rn,cn] = size(Pn);
[r0,~] = size(P0);
a = fix(rn/3);
b = fix(cn/3);
scale = log2(r0/rn);

L = [];
count = 1;
for i = 2:3:a*3
    for j = 2:3:b*3
        n = [H(i,j);H(i-1,j);H(i+1,j);H(i,j-1);H(i,j+1);H(i-1,j-1);H(i-1,j+1);H(i+1,j-1);H(i+1,j+1)];
        [val,lo] = max(n);
        if val>4000
            switch lo
                case 1
                 L(count,1) = j*(2^scale);
                 L(count,2) = i*(2^scale);
                 L(count,3) = scale;
                 L(count,4) = H(i,j);
                case 2 
                 L(count,1) = j*(2^scale);   
                 L(count,2) = (i-1)*(2^scale);
                 L(count,3) = scale;
                 L(count,4) = H(i-1,j);
                case 3 
                 L(count,1) = j*(2^scale);
                 L(count,2) = (i+1)*(2^scale);
                 L(count,3) = scale;
                 L(count,4) = H(i+1,j);
                 case 4
                 L(count,1) = (j-1)*(2^scale);
                 L(count,2) = i*(2^scale);
                 L(count,3) = scale;
                 L(count,4) = H(i,j-1);
                 case 5
                 L(count,1) = (j+1)*(2^scale);
                 L(count,2) = i*(2^scale);
                 L(count,3) = scale;
                 L(count,4) = H(i,j+1);
                 case 6
                 L(count,1) = (j-1)*(2^scale);
                 L(count,2) = (i-1)*(2^scale);
                 L(count,3) = scale;
                 L(count,4) = H(i-1,j-1);
                 case 7
                 L(count,1) = (j+1)*(2^scale);
                 L(count,2) = (i-1)*(2^scale);
                 L(count,3) = scale;
                 L(count,4) = H(i-1,j+1);
                 case 8   
                 L(count,1) = (j-1)*(2^scale);
                 L(count,2) = (i+1)*(2^scale);
                 L(count,3) = scale;
                 L(count,4) = H(i+1,j-1);
                 case 9   
                 L(count,1) = (j+1)*(2^scale);
                 L(count,2) = (i+1)*(2^scale);
                 L(count,3) = scale;
                 L(count,4) = H(i+1,j+1);
            end
            count = count+1;
        end
    end
end

end

