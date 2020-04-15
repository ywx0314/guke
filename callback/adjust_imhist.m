function handles = adjust_imhist(handles)
global stateStack;
previous = struct;
fn = fieldnames(handles);
for i = 1:length(fn)    
    if ishandle(handles.(fn{i}))
         previous.(fn{i}) = copy(handles.(fn{i}));
         if isa(handles.(fn{i}) ,'matlab.ui.Figure')
             close(previous.(fn{i}))
         end                       
    else
        previous.(fn{i}) = handles.(fn{i});
    end
end
stateStack.push(previous);
current_select = get(handles.IMname_listbox,'value');    
ref_img = handles.RawIm{current_select};
ref_size = size(ref_img);
sz = [length(handles.RawIm),ref_size];
allImg = zeros(sz);
for i = 1:length(handles.RawIm)
    if i == current_select
        allImg(i,:,:) = handles.RawIm{i};
    else
        allImg(i,:,:) = imresize(handles.RawIm{i},ref_size);
    end
end
ref_img = mean(allImg,1);
newSz = size(ref_img);
newSz = newSz(2:end);
ref_img = uint16(reshape(ref_img,newSz));
for i = 1:length(handles.RawIm)
    handles.RawIm{i} = imhistmatch(handles.RawIm{i},ref_img);
end
    
    
tallImg = simpleStack(handles.RawIm);
plotTallImage(tallImg,handles.axes1);

end

