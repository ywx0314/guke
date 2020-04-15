function StitchingRaw

impath = 'C:\Users\Administrator\Dropbox\Shanghai Career\Shanghai Taoimage Corp\20171030 Whole Body Scan\20190324 StitchingImages\Images';
rawlist = dir([impath, '\*.raw']);
RawFileNames = {rawlist.name};

%%% Import All Raw Images
tic
for i = 1:length(RawFileNames)
    [RM,RawHead]=RMreading([impath, '\', RawFileNames{i}]);
    RM = uint16(RM(9:end-8, 9:end-8));
    % imtool(RM)
    % [min(RM(:)) max(RM(:)) range(RM(:))]
    DICOM{i} = imresize(RM, 0.36);
end
toc

for i = 1:length(RawFileNames)
    
    % step2: filter
    RM = double(DICOM{i});
    Hf = fspecial('gaussian',3,1);
    RMf = imfilter(RM,Hf,'replicate');
    % step3: sharpen
    RMs = imsharpen(RMf,'Radius',5,'Amount',1.5);
    Hf = fspecial('gaussian',3,1);
    RMff = imfilter(RMs,Hf,'replicate');
    RMff = uint16(RMff);
%     % step4-1: HDR
%     RMd = double(RMff); 
%     HDR = cat(3,RMd,RMd,RMd);
%     LDR = tonemap(HDR); 
%     X_tone{i} = LDR(:,:,1); 
    
    % step4-2: locallapfilt
    X_imadjust = imadjust(RMff);
    X_imadjust = imadjust(X_imadjust, [0 0.3]);
    %%% Contrast-limited adaptive histogram equalization (CLAHE)
    X_adapthisteq = adapthisteq(X_imadjust,'clipLimit',0.02,'Distribution','exponential','NBins', 4096);
    sigma = 0.5;
    alpha = 0.5;
    %%% Fast Local Laplacian Filtering of images
    X_local{i} = locallapfilt(X_adapthisteq,sigma,alpha);
%     % step4-3: HDR
%     RMd = double(X_local{i}); 
%     HDR = cat(3,RMd,RMd,RMd);
%     LDR = tonemap(HDR); 
%     X_tone{i} = LDR(:,:,1); 
%     imtool(B1{i})
%     imtool(RMff)
    toc
end
% imtool(X_tone{1})
% imtool(X_local{1})
imgAP = {X_local{[1 6 8 10 12 3]}};

[C, D] = stitching(imgAP{1}, imgAP{2}, 0.15);
[C, D] = stitching(C, imgAP{3}, 0.15);
[C, D] = stitching(C, imgAP{4}, 0.15);
[C, D] = stitching(C, imgAP{5}, 0.15);
[C, D] = stitching(C, imgAP{6}, 0.15);
X_AP = C;
figure, imshow(C)
% imtool(C)

imgML = {X_local{[5 7 9 11 2 4]}};
[C, D] = stitching(imgML{1}, imgML{2}, 0.15);
[C, D] = stitching(C, imgML{3}, 0.15);
[C, D] = stitching(C, imgML{4}, 0.15);
[C, D] = stitching(C, imgML{5}, 0.15);
[C, D] = stitching(C, imgML{6}, 0.20);
X_ML = C;
figure, imshow(C)
% imtool(C)

%matlab????(????)
% 1??????
% 2?????????
% 3?????????
% 4?????????????

%???
%1???????????????????????
%2???????????????????
%3???? ?? ??
%4???? ? ?? ??

% % impath = 'D:\Dropbox\Shanghai Career\Shanghai Taoimage Corp\20171030 Whole Body Scan\20190322 two subject images\11-05 2804x2804\output0.1';
% % FileName = {'01', '03', '05', '07', '09', '11'};
% % FileEnding = '_local_tonemap_8bit.jpg';
% impath = 'D:\Dropbox\Shanghai Career\Shanghai Taoimage Corp\20171030 Whole Body Scan\20190322 phantom\try';
% 
% FileList = dir([impath, '\Emergency_*.jpg']);
% FileName = {FileList.name};
% FileName = {FileName{[2 3 5 4 6 1]}};
% FileEnding ='';
% 
% %???? ?? ??
% for i = 1:length(FileName)
%     img{i}=imread([impath, '\', FileName{i}, FileEnding]);
% end

function [C, D] = stitching(img1, img2, overpercent)
img1=rot90(img1);
img2=rot90(img2);
% figure;imshow(img1);%??
% figure;imshow(img2);

% %?????SIFT??,???????---------------------???? ??
% [des1, des2] = siftMatch(img{1}, img{2});
% des1=[des1(:,2),des1(:,1)];%???x?y??? ?????F ????????
% des2=[des2(:,2),des2(:,1)];%

% %? ????F ?????????
% matchs = matchFSelect(des1, des2) %??????????
% des1=des1(matchs,:);%????
% des2=des2(matchs,:);

% % ???????????????
% drawLinedCorner(img1,des1,img2, des2) ;
% %------------------------------------------------------???? ??

[H,W,k]=size(img1);%????
[H2,W2,k2]=size(img2);%????
% l_r=W-des1(1,2)+des2(1,2);%??????????????????
l_r=round(H*overpercent); %????????


% 1?????-------------------------------------------------

%[H,W,k]=size(img1);
%l_r=405;%?????W-? ? W?---?????????????????
L=W+1-l_r;%????
R=W;%????
n=R-L+1;%???????l_r
%?????
im=[img1,img2(:,n:W2,:)];%1??+2?????
% figure;imshow(im);title('?????');

% 2????????-------------------------------------------------
%????H????????????l_r???
A=img1(:,L:R,:);
B=img2(:,1:n,:);
%A?B ?????????????

% A=uint8(A); figure;imshow(A);
% B=uint8(B);figure;imshow(B);
%
[ma,na,ka]=size(A);
%I1=rgb2gray(A);%???????
I1 = A;
I1=double(I1);%??????
v1=0;
%I2= rgb2gray(B);
I2 = B;
I2=double(I2);
v2=0;
for i=1:ma
    for j=1:na
        %I1(i,j)=0.59*A(i,j,1)+0.11*A(i,j,2)+0.3*A(i,j,3);%????????
        v1=v1+I1(i,j);%??????????
        %I2(i,j)=0.59*B(i,j,1)+0.11*B(i,j,2)+0.3*B(i,j,3);
        v2=v2+I2(i,j);
    end
end

%figure;imshow(I1,[]);
%figure;imshow(I2,[]);

%???????????????
k=v1/v2;

BB2=img2(:,n:W2,:)*k;%???
im2=[img1,BB2];%??
% figure;imshow(im2);title('????????');


% 3????????-------------------------------------------------
% 4?????????????----------------------------------------

% ??????????

%????????????????

%[H,Y,t]=size(im);
C=im;%????
D=im2;%????????
% n=???;
%for i=1:H %?????
for j=1:n
    d=1-(j)/n;%disp(d);% ????
    C(1:H,L+j,:)=d*A(1:H,j,:)+(1-d)*B(1:H,j,:);%????
    D(1:H,L+j,:)=d*A(1:H,j,:)+(1-d)*B(1:H,j,:)*k;
end
%end
if isa(C, 'uint8')
    C=rot90(uint8(C), -1);
    % figure;imshow(C);title('???????');%3
    D=rot90(uint8(D), -1);
    % figure;imshow(D);title('??????????');%4
elseif isa(C, 'uint16')
    C=rot90(uint16(C), -1);
    % figure;imshow(C);title('???????');%3
    D=rot90(uint16(D), -1);
    % figure;imshow(D);title('??????????');%4
end

function [RM,RawHead]=RMreading(filename)
width=2816; height=2816; head=0; precision='uint16';
fid=fopen(filename,'r');
if fid<0,
    disp('Wrong! Please check the filename and/or pathname...');
else
    fseek(fid,0,'bof');
    RawHead=fread(fid,[1,head/2],'*uint16');
    fseek(fid,head,'bof');
    ftell(fid);
    RM=fread(fid,[width,height],precision);
    RM=RM';
    fclose(fid);
end
