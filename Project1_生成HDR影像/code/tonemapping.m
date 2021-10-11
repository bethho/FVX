function [ imag ] = tonemapping( hdr )
%covert HDR image to displayed type
R = hdr(:,:,1);
G = hdr(:,:,2);
B = hdr(:,:,3);
inten =  1/61*(R*20+G*40+B);

r = R./inten;
g = R./inten;
b = R./inten;

Base = Bilateral(log(inten));
Detail = log(inten) - Base;
M = max(Base(:));
m = min(Base(:));
Comfactor = 1/(M-m);
Scale = M*Comfactor;

F_inten = Comfactor*Base + Detail - Scale;

imag(:,:,1) = r*10^(F_inten);
imag(:,:,2) = g*10^(F_inten);
imag(:,:,3) = b*10^(F_inten);

end

