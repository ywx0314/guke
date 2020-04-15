function handles = figureKeyPressCallback(handles,eventdata)
%FIGUREKEYPRESS 此处显示有关此函数的摘要
%   此处显示详细说明
global stateStack;

if strcmp(eventdata.EventName,'KeyPress')
    if strcmp(eventdata.Key ,'backspace')
        if ~stateStack.isempty()
            previous = stateStack.pop();
            fn = fieldnames(handles);
            for i = 1:length(fn)
                if ~ishandle(handles.(fn{i}))
                handles.(fn{i}) = previous.(fn{i});
                end
            end
            try
            handles.axes1.Children(end).CData = previous.axes1.Children(end).CData;
            handles.axes1.Children(end).XData = previous.axes1.Children(end).XData;
            handles.axes1.Children(end).YData = previous.axes1.Children(end).YData;
            catch
            for i=1:length(handles.axes1.Children)
                handles.axes1.Children(i).CData = previous.axes1.Children(i).CData;
                handles.axes1.Children(i).XData = previous.axes1.Children(i).XData;
                handles.axes1.Children(i).YData = previous.axes1.Children(i).YData; 
            end
            end
            hold on;
            for i = 1:length(handles.wholeImg.stitchRowNumList)
                highlightStitch(handles.wholeImg.stitchRowNumList(i),handles.axes1,handles.totalWidth,'b',35,70)
            end
            
            if isfield(handles,'activeStitch')
                refreshStitchWithSelect(handles.activeStitch,handles.wholeImg.stitchRowNumList,handles.axes1,size(handles.wholeImg.pixels,2));
            end
            hold off;
            
            
           
        end
        
    end
end
end

