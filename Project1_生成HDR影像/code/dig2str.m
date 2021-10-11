function s = dig2str(i,n)
%DIG2STR convert integer to string having predetermined number of digits
% >> s = dig2str(i,n) converts integer i to string s,
% padding zeros in front if necessary to obtain number of digits n.
%
% H. Capart 2003

s = int2str(i);
while length(s)<n
    s = ['0' s];
end;