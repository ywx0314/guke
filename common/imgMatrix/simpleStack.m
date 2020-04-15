function tallImage = simpleStack(imList)
%Stack the image vertically and produce one long tall image to show in
%which axe
%   img_list: the list of img(the order decieds the order of stacking)
%   which_axe: which axe to show
ImNum = size(imList, 2);
tallImage = [];
for i = 1: ImNum
    tallImage = [tallImage; imList{i}];
end

end

