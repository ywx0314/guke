function rgbImage = gif(fullFileName)
[gifImage, cmap] = imread(fullFileName, 'Frames', 'all');
[rows, columns, ~, numImages] = size(gifImage);
% Construct an RGB movie.
rgbImage = zeros(rows, columns, 3, numImages, 'uint8'); % Initialize dimensions.
% hFig = figure;
for k = 1 : numImages
  thisFrame = gifImage(:,:,:, k);
  thisRGB = uint8(255 * ind2rgb(thisFrame, cmap));
%   imshow(thisRGB);
  rgbImage(:,:,:,k) = thisRGB;
%   caption = sprintf('Frame %#d of %d', k, numImages);
%   title(caption);
%   drawnow;
end
% close(hFig);
% Show the constructed movie.
% uiwait(msgbox('Click OK to bring up the GIF in implay'));
% implay(rgbImage);
end