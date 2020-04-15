function setCamera(whichAxe,camParams)
%READCAMERA 此处显示有关此函数的摘要
%   此处显示详细说明
campos(whichAxe,camParams.pos);
camproj(whichAxe,camParams.proj);
camtarget(whichAxe,camParams.target);
camup(whichAxe,camParams.up);
camva(whichAxe,camParams.va);
end

