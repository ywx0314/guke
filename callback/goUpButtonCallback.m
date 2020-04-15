function handles = goUpButtonCallback(handles)

img_list_contents = cellstr(get(handles.IMname_listbox,'string'));
current_select = get(handles.IMname_listbox,'value');
tmp = img_list_contents{current_select};
tmp_img = handles.RawIm(current_select);
if current_select > 1
    img_list_contents{current_select} = img_list_contents{current_select-1};
    img_list_contents{current_select-1} = tmp;
    handles.RawIm(current_select) = handles.RawIm(current_select-1);
    handles.RawIm(current_select-1)= tmp_img;
    set(handles.IMname_listbox,'string',img_list_contents);
    set(handles.IMname_listbox,'value',current_select-1);
    tallImg = simpleStack(handles.RawIm);
    plotTallImage(tallImg,handles.axes1);
end
end