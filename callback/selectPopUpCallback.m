function handles = selectPopUpCallback(hObject,handles)
contents = cellstr(get(hObject,'String'));
total = length(contents);
current_select = str2num(contents{get(hObject,'Value')});
%stitch_height_pixel = handles.wholeImg.stitchRowNumList(current_select);
refreshStitchWithSelect(current_select,handles.wholeImg.stitchRowNumList,handles.axes1,size(handles.wholeImg.pixels,2));
handles.activeStitch = current_select;

end