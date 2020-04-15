function handles = fuseCallback(handles)
%FUSECALLBACK �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
global stateStack;
previous = struct;
fn = fieldnames(handles);
for i = 1:length(fn)    
    if ishandle(handles.(fn{i}))
        if ~isnumeric(handles.(fn{i}))
             previous.(fn{i}) = copy(handles.(fn{i}));
             if isa(handles.(fn{i}) ,'matlab.ui.Figure')
                 close(previous.(fn{i}))
             end 
        else
            previous.(fn{i}) = handles.(fn{i});
        end
    else
        previous.(fn{i}) = handles.(fn{i});
    end
end
stateStack.push(previous);
handles.wholeImg.pixels = fuse(handles.wholeImg);
plotTallImage(handles.wholeImg.pixels,handles.axes1);
if isfield(handles,'activeStitch')
    refreshStitchWithSelect(handles.activeStitch,handles.wholeImg.stitchRowNumList,handles.axes1,size(handles.wholeImg.pixels,2));
else
    refreshStitchWithSelect(-1,handles.wholeImg.stitchRowNumList,handles.axes1,size(handles.wholeImg.pixels,2));
end
end

