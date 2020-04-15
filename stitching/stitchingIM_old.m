function [Opimg, Index] = stitchingIM(F, S, BandSize)
% BandSize;
F = rot90(F, 1);
S = rot90(S, 1);
%Converting color images to Grayscale
% F = im2double(F);
% S = im2double(S);% rgb2gray

[rows1 cols1] = size(S);
[rows cols] = size(F);

Tmp = [];
Tmp1 = [];
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

[Min_value, Index] = max(Tmp);% Gets the Index with maximum value from Tmp.

% Determining the number of columns of new image. Rows remain the same.
n_cols = Index + cols - 1;

Opimg = [];
Opimg = F;
Opimg(:, Index:Index+cols1-1) = S;

[r_Opimg c_Opimg] = size(Opimg);

Opimg = rot90(Opimg, -1);
end

