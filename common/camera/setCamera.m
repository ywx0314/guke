function setCamera(whichAxe,camParams)
%READCAMERA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
campos(whichAxe,camParams.pos);
camproj(whichAxe,camParams.proj);
camtarget(whichAxe,camParams.target);
camup(whichAxe,camParams.up);
camva(whichAxe,camParams.va);
end

