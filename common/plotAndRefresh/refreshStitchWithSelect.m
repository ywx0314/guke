function refreshStitchWithSelect(select,stitchRowNumList,whichAxe,imgWidth)
%REFRESHSTITCHWITHSELECT �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
delete(findall(whichAxe,'type','scatter'));
delete(findall(whichAxe,'type','line'));
hold on;
for i = 1:length(stitchRowNumList)
    if i ~= select
        highlightStitch(stitchRowNumList(i),whichAxe,imgWidth,'b',35,70);
    else
        highlightStitch(stitchRowNumList(i),whichAxe,imgWidth,'r',50,85);
    end
end
hold off;
end

