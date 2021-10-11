function [ Nmove ] = level( R , C , m_R , m_C , move )
% moving binary image and mask at current level and calculating moving
% direction at next level

[r,c] = size(R);
if move(1) > 0
    u = move(1);
    C(:,1:u) = [];
    m_C(:,1:u) = [];
    R(:,(c-u+1):c)=[];
    m_R(:,(c-u+1):c)=[];
 end
 if move(1) < 0
    u = abs(move(1));
    C(:,(c-u+1):c) = [];
    m_C(:,(c-u+1):c) = [];
    R(:,1:u)=[];
    m_R(:,1:u)=[];
 end
 if move(2) > 0
     v = move(2);
     C(1:v,:) = [];
     m_C(1:v,:) = [];
     R((r-v+1):r,:) = [];
     m_R((r-v+1):r,:) = [];
 end
 if move(2) < 0
    v = abs(move(2));
    C((r-v+1):r,:) = [];
    m_C((r-v+1):r,:) = [];
    R(1:v,:) = [];
    m_R(1:v,:) = [];
 end
 
 Nmove = direction(R , C , m_R , m_C);
 
end

