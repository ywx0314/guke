function [Opimg, Index] = stitchingIM(F, S, BandSize)
% based on different kinds of image(ruler or human) call different
% processing function
image1_txt = F(end-399:end, 1408-399:1408+400);
%%%% figure, imshow(image1_txt, [0 60000]); hold on;
[words,~]= FindNum(image1_txt);

if ~isempty(words)
    [Opimg,Index] = stitchRulerPicture(F,S);
else
    [Opimg,Index] = stitchHumanPicture(F,S,BandSize);
end
end

