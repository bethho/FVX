figure
t = B;
y = g(:,1,3);
x = 0:255;
plot( y,x, 'o')
hold on
plot(t(x),x,'LineWidth',4)
title('Response curve on B channel')
xlabel('log(exposure(X))')
ylabel('pixel value (Z_i_j)')