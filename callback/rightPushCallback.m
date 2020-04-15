function handles = rightPushCallback(handles)
step = handles.defaultStep;
cameraParams = readCamera(handles.axes1);
if isfield(handles,'activeStitch')
    current_stitch = handles.activeStitch;
    handles.wholeImg = handles.wholeImg.processLeftRight(current_stitch,step);
    clearAxe(handles.axes1);
    
    plotTallImage(handles.wholeImg.pixels,handles.axes1);
    refreshStitchWithSelect(current_stitch,handles.wholeImg.stitchRowNumList,handles.axes1,size(handles.wholeImg.pixels,2));
    setCamera(handles.axes1,cameraParams);
else
    msgbox('please choose a stitch on the left popup menu named stitch first','Activate stitch','help');
end
end