function handles = findIndexPushCallback(handles)
h = waitbar(0,'Please wait...');
steps = (handles.ImNum-1); n = 1;
% DICOM image DIC Stitching
DICStichLocation(1) = 0;
WholeIm = handles.RawIm{1};

for i =1:steps 
    [WholeIm, DICStichLocation(i+1)] = stitchingIM( WholeIm, handles.RawIm{i+1}, 10);
    waitbar(n / steps); n = n+1;
end
WholeIm = double(WholeIm);
close(h)
% plot stitching image
axes(handles.axes1);
imshow(WholeIm, [min(WholeIm(:)) max(WholeIm(:))]);
% create imPatch instances and put them into a list

stitching_places_pixel_per_image = diff(DICStichLocation);
for i = 1:length(stitching_places_pixel_per_image)
    imPatchList(i) = imPatch(handles.RawIm{i},stitching_places_pixel_per_image(i));
end
imPatchList(handles.ImNum) = imPatch(handles.RawIm{handles.ImNum});
% create wholeImg instace
wholeImgInst = wholeImg(WholeIm,imPatchList,handles.ImNum,DICStichLocation(2:end));
% pass important data structures into handles
handles.imPatchList = imPatchList;
handles.wholeImg = wholeImgInst;
handles.totalHeight = size(WholeIm,1);
handles.totalWidth = size(WholeIm,2);
% now the manual stitching begins, activate select popup
stitching_places = 1:steps;
set(handles.select_popup,'String',stitching_places);
% 
hold on;
for i = 1:length(handles.wholeImg.stitchRowNumList)
    highlightStitch(handles.wholeImg.stitchRowNumList(i),handles.axes1,handles.totalWidth,'b',35,70)
end
hold off;
%plotDetailImage(WholeIm,handles.axes2,handles.axeUIPanel);
end