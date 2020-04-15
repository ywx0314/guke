function handles = exportCallback(handles)
%EXPORTCALLBACK �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
leftMargin = inf;
rightMargin = inf;
for i = 1:handles.wholeImg.patchNum
    if handles.wholeImg.imPatchList(i).leftRoom < leftMargin
        leftMargin = handles.wholeImg.imPatchList(i).leftRoom;
    end
    if handles.wholeImg.imPatchList(i).rightRoom < rightMargin
        rightMargin = handles.wholeImg.imPatchList(i).rightRoom;
    end
end
[~,~,common_substring] = lcs(handles.DCMList{1},handles.DCMList{2});
if ~exist('output', 'dir')
       mkdir('output')
end


if strcmp(handles.dtype,'uint16')
    img = uint16(handles.wholeImg.pixels(:,leftMargin+1:end-rightMargin));
else
    img = uint8(handles.wholeImg.pixels(:,leftMargin+1:end-rightMargin));   
end
img = insertHighlightTri(img,handles.wholeImg.stitchRowNumList,60);
imwrite(img,['output/',common_substring,'.png']) 
handles.activeStitch= 1;
end

