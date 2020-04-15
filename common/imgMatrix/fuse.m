function fuseImg = fuse(wholeImgInst)
%FUSE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

if wholeImgInst.patchNum < 2
    fuseImg = wholeImgInst.pixels;
    return
end
[fuseImg,~] = wholeImgInst.imPatchList(1).getInfoForFusion();
for i = 1:wholeImgInst.patchNum-1
    [~,bandHeight] = wholeImgInst.imPatchList(i).getInfoForFusion();
    [belowImg,~] = wholeImgInst.imPatchList(i+1).getInfoForFusion();
    if bandHeight < 0
        fuseImg = [fuseImg;belowImg];
    else
        percent = bandHeight/ size(fuseImg,1);
        [~,fuseImg] = stitching(fuseImg,belowImg,percent);
    end
    
end
end

