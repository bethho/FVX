function [ X,Y ] = matching( des1,des2,fp1,fp2 )
%--------------input-----------------------------
%des1:discriptor of fp in first image, a matrix(64*fp num)
%des1:discriptor of fp in second image, a matrix(64*fp num)
%fp1:fp location of first image, a matrix
%(fpnum*3),column:x(column),y(row),level(scale)
%fp1:fp location of secondt image
%--------------output----------------------------
% X: x location(column) of matching fp pair,a matrix(2*matching pair
% num),row:first row is for first image,second row is for second imagee
%------------------------------------------------


[~,c1] = size(des1);
[~,c2] = size(des2);

% use second image to scan first image
com = []; %compared mar=trix
for i = 1:c2
    M = zeros(1,3);
    for j = 1:c1
        simi = dot(des2(:,i),des1(:,j))/(norm(des2(:,i))*norm(des1(:,j))); % compute cosine similarity
        if j == 1
            M(1,1) = simi;
            M(1,2) = j;    % first image
            M(1,3) = i;    %second image
        else 
            if simi>M(1,1)
                M(1,1) = simi;
                M(1,2) = j;    % first image
                M(1,3) = i;    %second image 
            end
        end
    end
    if M(1,1)>=0.7
        com = [com;M];
    end
end

% delete repeated matching fp in compared matrix
[r,~] = size(com);

for i = 1:r
    if com(i,2) ~= 0
        a = com(find(com(:,2) == com(i,2)),:);
        [~,b] = max(a(:,1));
        [r1,~] = size(a);
        for j = 1:r1
           if j ~= b
           com(a(j,3),:) = 0;
           end
        end
    end
end

com(find(com(:,2)==0),:) = [];

% fill position of matching fp
[r3,~] = size(com);
X = zeros(2,r3);
Y = zeros(2,r3);
for i = 1:r3
    X(1,i) = fp1(com(i,2),1);
    Y(1,i) = fp1(com(i,2),2);
    X(2,i) = fp2(com(i,3),1);
    Y(2,i) = fp2(com(i,3),2);
end


end

