function [ move ] = direction(B_R , B_C , m_R , m_C)
%decide moving direction

%difference in 9 directions
D=zeros(9,1); 

[r,c] = size(B_C);
%non-moving
m1 = ones(r,c);
m1(m_R==0 | m_C==0) = 0; %mask ¾ζ떠
S1 = abs(B_R-B_C);
S1=S1.*m1;
D(1)=nnz(S1);
%up
u_B_C = B_C;
u_B_C(1,:) = [];
u_m_C = m_C;
u_m_C(1,:) = [];
u_B_R = B_R;
u_B_R(r,:) = [];
u_m_R = m_R;
u_m_R(r,:) = [];
m2 = ones(r-1,c);
m2(u_m_R==0 | u_m_C==0) = 0; %mask ¾ζ떠
S2 = abs(u_B_R-u_B_C);
S2 = S2.*m2;
D(2) = nnz(S2);
%down
d_B_C = B_C;
d_B_C(r,:) = [];
d_m_C = m_C;
d_m_C(r,:) = [];
d_B_R = B_R;
d_B_R(1,:) = [];
d_m_R = m_R;
d_m_R(1,:) = [];
m3 = ones(r-1,c);
m3(d_m_R==0 | d_m_C==0) = 0; %mask ¾ζ떠
S3_ = abs(d_B_R-d_B_C);
S3_=S3_.*m3;
D(3)=nnz(S3_);
%left
L_B_C = B_C;
L_B_C(:,1) = [];
L_m_C = m_C;
L_m_C(:,1) = [];
L_B_R = B_R;
L_B_R(:,c) = [];
L_m_R = m_R;
L_m_R(:,c) = [];
m4 = ones(r,c-1);
m4(L_m_R==0 | L_m_C==0) = 0; %mask ¾ζ떠
S4 = abs(L_B_R-L_B_C);
S4=S4.*m4;
D(4)=nnz(S4);
%right
R_B_C = B_C;
R_B_C(:,c) = [];
R_m_C = m_C;
R_m_C(:,c) = [];
R_B_R = B_R;
R_B_R(:,1) = [];
R_m_R = m_R;
R_m_R(:,1) = [];
m5 = ones(r,c-1);
m5(R_m_R==0 | R_m_C==0) = 0; %mask ¾ζ떠
S5 = abs(R_B_R - R_B_C);
S5=S5.*m5;
D(5)=nnz(S5);
%up left
uL_B_C = B_C;
uL_B_C(:,1) = [];
uL_B_C(1,:) = [];
uL_m_C = m_C;
uL_m_C(:,1) = [];
uL_m_C(1,:) = [];
uL_B_R = B_R;
uL_B_R(:,c) = [];
uL_B_R(r,:) = [];
uL_m_R = m_R;
uL_m_R(:,c) = [];
uL_m_R(r,:) = [];
m6 =  ones(r-1,c-1);
m6(uL_m_R==0 | uL_m_C==0) = 0;
S6 = abs(uL_B_R - uL_B_C);
S6 = S6.*m6;
D(6) = nnz(S6);
%up right
uR_B_C = B_C;
uR_B_C(:,c) = [];
uR_B_C(1,:) = [];
uR_m_C = m_C;
uR_m_C(:,c) = [];
uR_m_C(1,:) = [];
uR_B_R = B_R;
uR_B_R(:,1) = [];
uR_B_R(r,:) = [];
uR_m_R = m_R;
uR_m_R(:,1) = [];
uR_m_R(r,:) = [];
m7 =  ones(r-1,c-1);
m7(uR_m_R==0 | uR_m_C==0) = 0;
S7 = abs(uR_B_R - uR_B_C);
S7 = S7.*m7;
D(7) = nnz(S7);
%down left
dL_B_C = B_C;
dL_B_C(:,1) = [];
dL_B_C(r,:) = [];
dL_m_C = m_C;
dL_m_C(:,1) = [];
dL_m_C(r,:) = [];
dL_B_R = B_R;
dL_B_R(:,c) = [];
dL_B_R(1,:) = [];
dL_m_R = m_R;
dL_m_R(:,c) = [];
dL_m_R(1,:) = [];
m8 =  ones(r-1,c-1);
m8(dL_m_R==0 | dL_m_C==0) = 0;
S8 = abs(dL_B_R - dL_B_C);
S8 = S8.*m8;
D(8) = nnz(S8);
%down right
dR_B_C = B_C;
dR_B_C(:,c) = [];
dR_B_C(r,:) = [];
dR_m_C = m_C;
dR_m_C(:,c) = [];
dR_m_C(r,:) = [];
dR_B_R = B_R;
dR_B_R(:,1) = [];
dR_B_R(1,:) = [];
dR_m_R = m_R;
dR_m_R(:,1) = [];
dR_m_R(1,:) = [];
m9 =  ones(r-1,c-1);
m9(dR_m_R==0 | dR_m_C==0) = 0;
S9 = abs(dR_B_R - dR_B_C);
S9 = S9.*m9;
D(9) = nnz(S9);

[m,type] = min(D);

switch type
    case 1
        move = [0 0];
    case 2
        move = [0 1];
    case 3
        move = [0 -1];
    case 4
        move = [1 0];
    case 5
        move = [-1 0];
    case 6
        move = [1 1];
    case 7
        move = [-1 1];
    case 8
        move = [1 -1];
    case 9
        move = [-1 -1];
end
      
end

