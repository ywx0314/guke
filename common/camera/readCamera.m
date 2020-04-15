function camParams = readCamera(whichAxe)
%READCAMERA 此处显示有关此函数的摘要
%   此处显示详细说明
camParams.pos = campos(whichAxe);
camParams.proj = camproj(whichAxe);
camParams.target = camtarget(whichAxe);
camParams.up = camup(whichAxe);
camParams.va = camva(whichAxe);
end

