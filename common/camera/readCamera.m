function camParams = readCamera(whichAxe)
%READCAMERA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
camParams.pos = campos(whichAxe);
camParams.proj = camproj(whichAxe);
camParams.target = camtarget(whichAxe);
camParams.up = camup(whichAxe);
camParams.va = camva(whichAxe);
end

