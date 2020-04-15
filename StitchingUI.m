function varargout = StitchingUI(varargin)
% STITCHINGUI MATLAB code for StitchingUI.fig
%      STITCHINGUI, by itself, creates a new STITCHINGUI or raises the existing
%      singleton*.
%
%      H = STITCHINGUI returns the handle to a new STITCHINGUI or the handle to
%      the existing singleton*.
%
%      STITCHINGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STITCHINGUI.M with the given input arguments.
%
%      STITCHINGUI('Property','Value',...) creates a new STITCHINGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before StitchingUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to StitchingUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help StitchingUI

% Last Modified by GUIDE v2.5 15-Jan-2020 10:06:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @StitchingUI_OpeningFcn, ...
                   'gui_OutputFcn',  @StitchingUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before StitchingUI is made visible.
function StitchingUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to StitchingUI (see VARARGIN)

% Choose default command line output for StitchingUI
handles.output = hObject;
addpath('callback',genpath('common'),'stitching','datastructure');
cameratoolbar('show');
global stateStack;
stateStack = CStack;

% grey out all buttons except select
handles = greyOutAllbuttonsExceptSelectIm(handles);

warning('off');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes StitchingUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = StitchingUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 frame = get(gcf,'JavaFrame');
 set(frame,'Maximized',1); 
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in IMname_listbox.
function IMname_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to IMname_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns IMname_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from IMname_listbox


% --- Executes during object creation, after setting all properties.
function IMname_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IMname_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function IMname_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IMname_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in goup_push.
function goup_push_Callback(hObject, eventdata, handles)
% hObject    handle to goup_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = goUpButtonCallback(handles);
guidata(hObject,handles);
    



% --- Executes on button press in godn_push.
function godn_push_Callback(hObject, eventdata, handles)
% hObject    handle to godn_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = goDownButtonCallback(handles);
guidata(hObject,handles);

% --- Executes on selection change in select_popup.
function select_popup_Callback(hObject, eventdata, handles)
% hObject    handle to select_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns select_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from select_popup
handles = selectPopUpCallback(hObject,handles);
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function select_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in step_popup.
function step_popup_Callback(hObject, eventdata, handles)
% hObject    handle to step_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns step_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from step_popup
contents = cellstr(get(hObject,'String'));
handles.defaultStep = str2num(contents{get(hObject,'Value')});
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function step_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'value',4);
handles.defaultStep = 10;
guidata(hObject,handles);


% --- Executes on button press in Up_push.
function Up_push_Callback(hObject, eventdata, handles)
% hObject    handle to Up_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = upPushCallback(handles);
guidata(hObject,handles);

% --- Executes on button press in Down_push.
function Down_push_Callback(hObject, eventdata, handles)
% hObject    handle to Down_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = downPushCallback(handles);
guidata(hObject,handles);



% --- Executes on button press in Right_push.
function Right_push_Callback(hObject, eventdata, handles)
% hObject    handle to Right_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = rightPushCallback(handles);
guidata(hObject,handles);


% --- Executes on button press in Left_push.
function Left_push_Callback(hObject, eventdata, handles)
% hObject    handle to Left_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = leftPushCallback(handles);
guidata(hObject,handles);



% --- Executes on button press in selectIM_push.
function selectIM_push_Callback(hObject, eventdata, handles)
% hObject    handle to selectIM_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% grey out buttons
handles = greyOutAllbuttonsExceptSelectIm(handles);
% do real pushCallback
handles = selectImPushCallback(handles);
% release sorting panel
for i=1:length(handles.sorting_panel.Children)
    set(handles.sorting_panel.Children(i),'Enable','on');
end
set(handles.autoStitchPush,'Enable','on');
for i = 1:length(handles.wlww_panel.Children)
    set(handles.wlww_panel.Children(i),'Enable','on');
end

% Update handles structure
guidata(hObject, handles);

% figure; montage(file, 'size', [NaN 1]);
% montage(onionArray,'size',[1 NaN]);

% --- Executes on button press in blend.
function blend_Callback(hObject, eventdata, handles)
% hObject    handle to blend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i=1:length(handles.manualStitch_panel.Children)
    set(handles.manualStitch_panel.Children(i),'Enable','off');
end
handles = fuseCallback(handles);
set(handles.export_push,'Enable','on');
set(handles.rollback_push,'Enable','on');
guidata(hObject,handles);



% --- Executes on button press in export_push.
function export_push_Callback(hObject, eventdata, handles)
% hObject    handle to export_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% make waitbar
f = uifigure;
p = uiprogressdlg(f,'Title','Writing image to disk','Indeterminate','on');
% grey buttons
handles = greyOutAllbuttonsExceptSelectIm(handles);
set(handles.selectIM_push,'Enable','off');
% callback
handles = exportCallback(handles);
% activate button
set(handles.selectIM_push,'Enable','on');
% destroy waitbar
close(p);
close(f);
guidata(hObject,handles);


% --- Executes on button press in Find_Index_push.
function Find_Index_push_Callback(hObject, eventdata, handles)
% hObject    handle to Find_Index_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = findIndexPushCallback(handles);
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in adjust_hist.
function adjust_hist_Callback(hObject, eventdata, handles)
% hObject    handle to adjust_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = adjust_imhist(handles);
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in adjust_linear.
function adjust_linear_Callback(hObject, eventdata, handles)
% hObject    handle to adjust_linear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = adjust_lt(handles);
% Update handles structure
guidata(hObject, handles);


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
handles = figureKeyPressCallback(handles,eventdata);
guidata(hObject,handles);


% --- Executes on button press in Undo.
function Undo_Callback(hObject, eventdata, handles)
% hObject    handle to Undo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myEventdata.EventName = 'KeyPress';
myEventdata.Key = 'backspace';
handles = figureKeyPressCallback(handles,myEventdata);
guidata(hObject,handles);


% --- Executes on slider movement.
function WL_slider_Callback(hObject, eventdata, handles)
% hObject    handle to WL_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
wl = get(hObject,'Value');
handles.windowLevel = wl;
ww = handles.windowWidth;
if round(wl-ww/2)>=0
    windowFloor = round(wl - ww/2);
else
    windowFloor = 0;
end
if strcmp(handles.dtype,'uint16')
    if round(wl+ww/2) <= 65535
        windowCeiling = round(wl+ww/2);
    else
        windowCeiling = 65535;
    end
else
    if round(wl+ww/2) <= 255
        windowCeiling = round(wl+ww/2);
    else
        windowCeiling = 255;
    end
end
if windowFloor == windowCeiling
    windowCeiling  = windowCeiling + 1;
end
set(handles.axes1,'CLim',[windowFloor windowCeiling]);
set(handles.WL_edit,'String',num2str(wl));




% --- Executes during object creation, after setting all properties.
function WL_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WL_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end






% --- Executes on slider movement.
function WW_slider_Callback(hObject, eventdata, handles)
% hObject    handle to WW_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
ww = get(hObject,'Value');
handles.windowWidth = ww;
wl = handles.windowLevel;
if round(wl-ww/2)>=0
    windowFloor = round(wl - ww/2);
else
    windowFloor = 0;
end
if strcmp(handles.dtype,'uint16')
    if round(wl+ww/2) <= 65535
        windowCeiling = round(wl+ww/2);
    else
        windowCeiling = 65535;
    end
else
    if round(wl+ww/2) <= 255
        windowCeiling = round(wl+ww/2);
    else
        windowCeiling = 255;
    end
end
if windowFloor == windowCeiling
    windowCeiling  = windowCeiling + 1;
end
set(handles.axes1,'CLim',[windowFloor windowCeiling]);
set(handles.WW_edit,'String',num2str(ww));


% --- Executes during object creation, after setting all properties.
function WW_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WW_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end






function WW_edit_Callback(hObject, eventdata, handles)
% hObject    handle to WW_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WW_edit as text
%        str2double(get(hObject,'String')) returns contents of WW_edit as a double
ww = str2double(get(hObject,'String'));
if ~isnan(ww)
    if isnumeric(ww)
        if ww >=0 && ww <= get(handles.WW_slider,'Max')
            set(handles.WW_slider,'Value',ww);
            handles.windowWidth = ww;
            wl = handles.windowLevel;
            if round(wl-ww/2)>=0
                windowFloor = round(wl - ww/2);
            else
                windowFloor = 0;
            end
            if strcmp(handles.dtype,'uint16')
                if round(wl+ww/2) <= 65535
                    windowCeiling = round(wl+ww/2);
                else
                    windowCeiling = 65535;
                end
            else
                if round(wl+ww/2) <= 255
                    windowCeiling = round(wl+ww/2);
                else
                    windowCeiling = 255;
                end
            end
            if windowFloor == windowCeiling
                windowCeiling  = windowCeiling + 1;
            end
            set(handles.axes1,'CLim',[windowFloor windowCeiling]);
        end
    end

end





% --- Executes during object creation, after setting all properties.
function WW_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WW_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function WL_edit_Callback(hObject, eventdata, handles)
% hObject    handle to WL_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WL_edit as text
%        str2double(get(hObject,'String')) returns contents of WL_edit as a double
wl = str2double(get(hObject,'String'));
if ~isnan(wl)
    if isnumeric(wl)
        if wl >=0 && wl <= get(handles.WL_slider,'Max')
            set(handles.WL_slider,'Value',wl);
            handles.windowLevel = wl;
            ww = handles.windowWidth;
            if round(wl-ww/2)>=0
                windowFloor = round(wl - ww/2);
            else
                windowFloor = 0;
            end
            if strcmp(handles.dtype,'uint16')
                if round(wl+ww/2) <= 65535
                    windowCeiling = round(wl+ww/2);
                else
                    windowCeiling = 65535;
                end
            else
                if round(wl+ww/2) <= 255
                    windowCeiling = round(wl+ww/2);
                else
                    windowCeiling = 255;
                end
            end
            if windowFloor == windowCeiling
                windowCeiling  = windowCeiling + 1;
            end
            set(handles.axes1,'CLim',[windowFloor windowCeiling]);
        end
    end

end


% --- Executes during object creation, after setting all properties.
function WL_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WL_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rollback_push.
function rollback_push_Callback(hObject, eventdata, handles)
% hObject    handle to rollback_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% grey out buttons
for i=1:length(handles.sorting_panel.Children)
    set(handles.sorting_panel.Children(i),'Enable','off');
end
set(handles.autoStitchPush,'Enable','off');
set(handles.rollback_push,'Enable','off');
set(handles.export_push,'Enable','off');
%activate buttons
for i=1:length(handles.manualStitch_panel.Children)
    set(handles.manualStitch_panel.Children(i),'Enable','on');
end
% roll back
myEventdata.EventName = 'KeyPress';
myEventdata.Key = 'backspace';
handles = figureKeyPressCallback(handles,myEventdata);
% activate buttons
for i=1:length(handles.manualStitch_panel.Children)
    set(handles.manualStitch_panel.Children(i),'Enable','on');
end
guidata(hObject,handles);

% --- Executes on button press in autoStitchPush.
function autoStitchPush_Callback(hObject, eventdata, handles)
% hObject    handle to autoStitchPush (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i=1:length(handles.sorting_panel.Children)
    set(handles.sorting_panel.Children(i),'Enable','off');
end
set(handles.selectIM_push,'Enable','off');

handles = findIndexPushCallback(handles);
handles = fuseCallback(handles);

set(handles.autoStitchPush,'Enable','off');
set(handles.export_push,'Enable','on');
set(handles.rollback_push,'Enable','on');
guidata(hObject,handles);
