function [Opimg, Index] = stitchHumanPicture(F, S, BandSize)
% BandSize;
F = rot90(F);
S = rot90(S);
%Converting color images to Grayscale
% F = im2double(F);
% S = im2double(S);% rgb2gray

[rows, cols] = size(F);
[~, cols1] = size(S);


Tmp = [];
% Tmp1 = [];
temp = 0;

% Saving the patch(rows x 5 columns) of second(S) & third(V) images in
% S1 & V1 resp for future use.
for i = 1:rows
    for j = 1:BandSize
        S1(i,j) = S(i,j);
    end
end

% Performing Correlation i.e. Comparing the (rows x 5 column) patch of
% first image with patch of second image i.e. S1 saved earlier.
for k = 0:cols-BandSize % (cols - 5) prevents j from going beyond boundary of image.
    for j = 1:BandSize
        F1(:,j) = F(:,k+j);% Forming patch of rows x 5 each time till cols-5.
    end
    temp = corr2(F1,S1);% comparing the patches using correlation.
    Tmp = [Tmp temp]; % Tmp keeps growing, forming a matrix of 1*cols
    temp = 0;
end

[Max_value, Index] = max(Tmp);% Gets the Index with maximum value from Tmp.

n = cols-Index+1;
A = F(:,Index:cols);
B = S(:,1:n);
k = mean2(double(A))/mean2(double(B));

% Determining the number of columns of new image. Rows remain the same.
n_cols = Index + cols - 1;
% Opimg = [];
Opimg = F;
Opimg(:, Index:Index+cols1-1) = S;
% 边缘融合
%{ 
Opimg2 = [F,S(:,n+1:cols1)];
for j=1:n
    d=1-(j)/n;%disp(d);% ????
    Opimg(:,Index+j-1)=d*A(:,j)+(1-d)*B(:,j);%????
    Opimg2(:,Index+j-1)=d*A(:,j)+(1-d)*B(:,j)*k;
end
%}

[r_Opimg c_Opimg] = size(Opimg);

Opimg = rot90(Opimg, -1);
end