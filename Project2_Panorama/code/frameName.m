function filename = frameName(seqname,i)
%FRAMENAME construct an indexed frame name based on a sequence name and an indice
% >> filename = frameName('name####.bmp',56)
% outputs string of characters filename = 'name0056.bmp'
%
% H. Capart 2004

isSharp = ( seqname == '#' ); % locate '#' (pronounced 'sharp') characters to be replaced by digits
numDigits = sum(isSharp); % count number of digits
string = dig2str(i,numDigits); % digit string
filename = seqname; 
filename(isSharp) = string; % replace '#' characters by digit string