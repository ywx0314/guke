function handles = selectImPushCallback(handles)
clearAxe(handles.axes1);
axes(handles.axes1);
% text(0.1,0.7,'Read, load and process the images£¡','FontSize',12,'FontWeight','bold');
% text(0.1,0.5,'Please waite about 1 minute...','FontSize',12,'FontWeight','bold');
[DCMList, DCMPath] = uigetfile('*.*', 'MultiSelect', 'on');
if ~iscell(DCMList)
    return
end
% waitbar making
f = uifigure;
p = uiprogressdlg(f,'Title','Loading Images,Please waite about 1 minute...','Indeterminate','on');

set(handles.IMname_listbox, 'String', DCMList);
ImNum = size(DCMList, 2);

% Image Process preparing
hsize = 3;
sigma = 1;
radius = 5;
amount = 5;
Hf = fspecial('gaussian',hsize,sigma);
Hf2 = fspecial('gaussian',hsize,sigma);
All = [];
for i = 1: ImNum
    [RawIm{i}, ~]= dicomread([DCMPath, '\', DCMList{i}]);


% %     Image Process preparing
    RM = double(RawIm{i});
    RMf = imfilter(RM,Hf,'replicate');
    RMs = imsharpen(RMf,'Radius',radius,'Amount',amount);
    RMs(RMs<=0)=1000;
    RMff = imfilter(RMs,Hf2,'replicate');
    RMd = abs(RMff); 
    HDR = cat(3,RMd,RMd,RMd);
    LDR = tonemap(HDR);
    RMout = LDR(:,:,1);
    RawIm{i} = RMout;
    

    All = [All; RawIm{i}];
    if i < ImNum
        stitching_places_pixel_per_image(i) = size(RawIm{i},1);
        stitching_places_pixel_in_total_height(i) = size(All,1);
    end
    
%     tao_im_1{i} = fliplr(tao_im_1{i});
    % figure; imshow(tao_im_1{i}) % figure; imshow(tao_im_2{i})
end
axes(handles.axes1);
imshow(All, [min(All(:)) max(All(:))]);

%imshow(ALL, map);
handles.DCMList = DCMList;
handles.DCMPath = DCMPath;
handles.RawIm = RawIm;
handles.ImNum = ImNum;
if isa(handles.RawIm{1},'uint16')
    handles.dtype = 'uint16';
elseif isa(handles.RawIm{1},'uint8')
    handles.dtype = 'uint8';
else
    msgbox('uint16 and uint8 is prefered.Your data type might have unexpected issues','Unsupported dtype','warn');
end
% set WW WL slider
if strcmp(handles.dtype,'uint16')
    set(handles.WW_slider,'Max',65535);
    set(handles.WL_slider,'Max',65535);
    set(handles.WL_slider,'Value',600); % WL of bone is 600
    set(handles.WW_slider,'Value',2500); % WW of bone is 2500
    set(handles.WL_edit,'String','600');
    set(handles.WW_edit,'String','2500');
    handles.windowLevel = 600;
    handles.windowWidth = 2500;
    
else
    set(handles.WW_slider,'Max',255);
    set(handles.WL_slider,'Max',255);
    set(handles.WL_slider,'Value',60); % WL of bone is 600
    set(handles.WW_slider,'Value',50); % WW of bone is 2500
    set(handles.WL_edit,'String','128');
    set(handles.WW_edit,'String','255');
    handles.windowLevel = 128;
    handles.windowWidth = 255;
end
set(handles.WW_slider,'Min',0);
set(handles.WL_slider,'Min',0);


% destroy waitbar
close(p);
close(f);

end