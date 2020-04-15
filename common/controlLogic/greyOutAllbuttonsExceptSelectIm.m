function handles = greyOutAllbuttonsExceptSelectIm(handles)
%GREYOUTALLBUTTONSEXCEPTSELECTIM 此处显示有关此函数的摘要
%   此处显示详细说明
% grey out all buttons except select
for i=1:length(handles.sorting_panel.Children)
    set(handles.sorting_panel.Children(i),'Enable','off');
end

set(handles.autoStitchPush,'Enable','off');
for i=1:length(handles.manualStitch_panel.Children)
    set(handles.manualStitch_panel.Children(i),'Enable','off');
end
set(handles.export_push,'Enable','off');
set(handles.rollback_push,'Enable','off');
for i = 1:length(handles.wlww_panel.Children)
    set(handles.wlww_panel.Children(i),'Enable','off');
end

end

