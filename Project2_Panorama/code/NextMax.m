function [ m,Nmr ] = NextMax( D,mr )


com = [];
[r,~] = size(com);
while r<2
  com = find(D(:,1)>mr);  %postion
  com(:,2) = D(com(:,1),2);  %CDF value
  [r,~] = size(com);
  mr = mr-1;
end
[~,m1] = max(com(:,2));
m = com(m1,1);
Nmr = mr;

end

