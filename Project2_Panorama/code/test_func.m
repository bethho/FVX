clear
clc
%% test RANSAC
img = ones(100,100);
shift_x = 10;
shift_y = 20;
[h,w] = size(img);
x = linspace(1,w,w);
y = linspace(1,h,h);
[X,Y] = meshgrid(x,y);
p = randperm(100*100,200);
X_f = [X(p);X(p)+shift_x];
Y_f = [Y(p);Y(p)+shift_y];
p = randperm(200,20);
pp = randi(5,1,20);
X_f(2,p) = X_f(2,p)+pp;
[XX1,YY1,H] = RANSAC(X_f,Y_f, 1000, 50);

%% eachfeature
clear
clc
img = ones(100,100);
img(1:100,50) = 0;
img(50,1:100) = 0;
feature = [100,100,1];
level{1,1} = imgaussfilt(img, 2);
level{1,2} = ones(100,100)*(1/2^0.5);
level{1,3} = ones(100,100)*(1/2^0.5);
[descriptor] = eachfeature(feature, level);
%%