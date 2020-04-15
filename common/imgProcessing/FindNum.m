function  [words,word_centers]= FindNum(image1_txt)
% Increase image size by 2x
angle = -1;
image1_txt1 = rot90(image1_txt, angle);
my_image = imresize(image1_txt1, 2);
% figure; imshow(my_image, [0 6000]); hold on;
% Localize words
BW = imbinarize(my_image,'adaptive','Sensitivity',0.80);
BW =~BW;
% figure; imshow(BW); hold on

BW1 = imdilate(BW,strel('disk',10));  %%%%% 6
% figure; imshow(BW1); hold on
s = regionprops(BW1,'BoundingBox', 'Area', 'Centroid');

% Find the Numbers
Areas = cat(1, s.Area); sort(Areas);
Centroids = cat(1, s.Centroid);
index = find(Areas>300&Areas<6000);  %%%%%

% plot(Centroids(index,1),Centroids(index,2), 'r*')

bboxes = vertcat(s(index).BoundingBox);

% Sort boxes by image x coordinate
[~,ord] = sort(bboxes(:,1));
bboxes = bboxes(ord,:);

% Pre-process image to make letters thicker
%BW = imdilate(BW,strel('disk',1));

% Call OCR and pass in location of words. Also, set TextLayout to 'word'
ocrResults = ocr(BW,bboxes,'CharacterSet','0123456789','TextLayout','word');
words = {ocrResults(:).Text}';
words = deblank(words);
A = cellfun(@isempty,words);
words(A)=[];
WordBoundingBoxes = {ocrResults.WordBoundingBoxes};
% WordBoundingBoxes = vertcat(ocrResults.WordBoundingBoxes);
WordBoundingBoxes(A)=[];
WordBoundingBoxes = vertcat(WordBoundingBoxes{:});
% word_centers = [bboxes(:, 1)+bboxes(:, 3)/2 bboxes(:, 2)+bboxes(:, 4)/2]/2;
word_centers = [WordBoundingBoxes(:, 1)+WordBoundingBoxes(:, 3)/2 WordBoundingBoxes(:, 2)+WordBoundingBoxes(:, 4)/2]/2;

if angle == 1
    word_centers(:, 2) = 801-word_centers(:, 2); %%%
elseif angle == -1
    word_centers(:, 1) = 400-word_centers(:, 1); %%%
end