function [New, stich_pos] = stitchRulerPicture(image1, image2)
rows1 = size(image1, 1); % 2816;
colums1 = size(image1, 2); % 2816

image1_txt = image1(end-399:end, 1408-399:1408+400);
%%%% figure, imshow(image1_txt, [0 6000]); hold on;
[words1 word_centers1]= FindNum(image1_txt);
%%%% plot(word_centers1(:, 2), word_centers1(:, 1), 'g*');
%     figure, imshow(image1, [0 6000]); hold on;
%     plot(word_centers1(:, 2)+1014, word_centers1(:, 1)+(rows-399), 'g*');
word_centers1_g = [word_centers1(:, 1)+(rows1-399) word_centers1(:, 2)+1014];

image2_txt = image2(1:400, 1408-399:1408+400);
%%%% figure, imshow(image2_txt, [0 6000]); hold on;
[words2 word_centers2]= FindNum(image2_txt);
%%%% plot(word_centers2(:, 2), word_centers2(:, 1), 'g*');

%     figure, imshow(image2, [0 6000]); hold on;
%     plot(word_centers2(:, 2)+1014, word_centers2(:, 1), 'g*');
word_centers2_g = [word_centers2(:, 1) word_centers2(:, 2)+1014];

% Choose a number to align
for i = 1:size(words1, 1)
    for j = 1:size(words2, 1)
        tf(i, j) = strcmp(words1{i},words2{j});
    end
end
[m, n]= find(tf);

%%%% merge two images
% rows = 400;
% colums = 800;
% pos1 = round(word_centers1(3, :));
% pos2 = round(word_centers2(3, :));
% Image_Offset = pos1-pos2;

rows2 = size(image2, 1); % 2816;
colums2 = size(image2, 2); % 2816
image1_txt = image1;
image2_txt = image2;
pos1 = round(word_centers1_g(m(1), :));
pos2 = round(word_centers2_g(n(1), :));
Image_Offset = pos1-pos2; 
stich_pos = pos1(1);
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%
% Calculate Anchor to edge pixels.
image1_r1 = pos1(1);
image1_r2 = rows1-pos1(1);
image1_c1 = pos1(2);
image1_c2 = colums1-pos1(2);

image2_r1 = pos2(1);
image2_r2 = rows2-pos2(1);
image2_c1 = pos2(2);
image2_c2 = colums2-pos2(2);

% Calculate image size of zero matrix
if image1_r1>image2_r1
    R1 = image1_r1;
    img1_rpos = 1;
    img2_rpos = image1_r1-image2_r1;
elseif image2_r1>image1_r1
    R1 = image2_r1;
    img1_rpos = image2_r1-image1_r1;
    img2_rpos = 1;
elseif image1_r1 == image2_r1
    R1 = image2_r1;
    img1_rpos = 1;
    img2_rpos = 1;
end

if image1_r2>image2_r2
    R2 = image1_r2;
elseif image2_r2>image1_r2
    R2 = image2_r2;
elseif image1_r2 == image2_r2
    R2 = image2_r2;
end

if image1_c1>image2_c1
    C1 = image1_c1;
    img1_cpos = 1;
    img2_cpos = image1_c1-image2_c1;
elseif image2_c1>image1_c1
    C1 = image2_c1;
    img1_cpos = image2_c1-image1_c1;
    img2_cpos = 1;   
elseif image1_c1 == image2_c1
    C1 = image2_c1;
    img1_cpos = 1;
    img2_cpos = 1;
end
if image1_c2>image2_c2
    C2 = image1_c2;
elseif image2_c2>image1_c2
    C2 = image2_c2;
else
    C2 = image2_c2;
end

New1 = zeros(R1+R2, C1+C2);
New2 = New1;

New1(img1_rpos:img1_rpos+rows1-1, img1_cpos:img1_cpos+colums1-1) = image1_txt;
New2(img2_rpos:img2_rpos+rows2-1, img2_cpos:img2_cpos+colums2-1) = image2_txt;
% figure; imshow(New1, [0 6000]);
% figure; imshow(New2, [0 6000]);

%New = merge2im(New1, New2); 
New = [image1(1:stitch_pos,:);image2];
% figure; imshow(New, [0 6000]);
New = uint16(New);



% img1_cpos
% img1_rpos
% img2_cpos
% img2_rpos
% 
% rows1
% colums1
% pos1
% pos2


