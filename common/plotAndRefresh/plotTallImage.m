function plotTallImage(tallImage,whichAxe)
set(whichAxe,'clipping','off');
imshow(tallImage, [min(tallImage(:)) max(tallImage(:))],'InitialMagnification','fit','Parent',whichAxe);
end