function handles = adjust_lt(handles)
%ADJUST_LT 此处显示有关此函数的摘要
%   此处显示详细说明
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
if handles.dtype == 'uint16'
    largest = 65535;
else
    largest = 255;
end
% refT = graythresh(ref_img)*largest;
% refBone = mean(ref_img(ref_img > refT));
% refBackGround = mean(ref_img(ref_img < refT));
[N,edges] = histcounts(ref_img);
aboveZero = find(N>0);
low_i = aboveZero(2);
low_ref = (edges(low_i) + edges(low_i +1)) / 2;

high_i =  aboveZero(end-1);
high_ref = (edges(high_i) + edges(high_i +1)) / 2;


for i = 1:length(handles.RawIm)
    if i ~= current_select
        I = handles.RawIm{i};
        I_max = max(max(I,[],1));
        [N,edges] = histcounts(I);
        aboveZero = find(N>0);
        input_low_i = aboveZero(2);
        low_input = (edges(input_low_i) + edges(input_low_i +1)) / 2;

        input_high_i =  aboveZero(end-1);
        high_input = (edges(input_high_i) + edges(input_high_i +1)) / 2;
        
%         I_T = graythresh(I)*largest;
%         IBone = mean(I(I>I_T));
%         IBackGround = mean(I(I<I_T));
%         
%         adding = zeros(size(I));
%         adding(I>I_T) = refBone - IBone;
%         adding(I<I_T) = refBackGround -IBackGround;
%         
%         I = double(I) + adding;
        I = double(I);
        I(I>0&I<I_max) = (I(I>0&I<I_max) - low_input)/(high_input - low_input) * (high_ref - low_ref) + low_ref;
%         for i= 1:size(I,1)
%             for j = 1:size(I,2)
%                 if I(i,j) >0 && I(i,j) < 32767
%                     I(i,j) = (I(i,j) - low_input)/(high_input - low_input) * (high_ref - low_ref) + low_ref;
%                 end
%             end
%         end
        
        I(I<0) = 0;
        I(I>largest) = largest;
        if handles.dtype == 'uint16'
            I = uint16(I);
        else
            I = uint8(I);
        end
        handles.RawIm{i} = I;
        
            
    end
end
    
    
tallImg = simpleStack(handles.RawIm);
plotTallImage(tallImg,handles.axes1);
end

