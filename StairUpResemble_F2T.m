clc; clear;

fileID = fopen('Input_list.txt');
filedata = textscan(fileID, '%s');  fclose(fileID);
for i=1:length(filedata{1})/2
    SubjectID = filedata{1}{2*i-1};
    SubjectImplantSide = filedata{1}(2*i);
    RawData=xlsread('SN-Stair-Up result-kinematic Coor.xlsx',i);
    
    % the first char of varible name means the positive value
    frames(i,1) = length(RawData(:,1));   Start_frame(i,1) = RawData(1,1);end_frame(i,1)=RawData(end,1);  % some mistake when we do the interpertation
    A_P_Trans = RawData(:,2);  P_D_Trans = RawData(:,3);  
    M_L_Trans = RawData(:,4)*(-1)^strcmp(SubjectImplantSide{1},'R');
    F_E_Rot = -RawData(:,5);  ABD_ADD_Rot = RawData(:,6)*(-1)^strcmp(SubjectImplantSide{1},'R');
    E_I_Rot = RawData(:,7)*(-1)^strcmp(SubjectImplantSide{1},'R');
    %A_P_Trans = smooth(1:frames(i,1), A_P_Trans, 'rlowess');
    P_D_Trans = smooth(1:frames(i,1), P_D_Trans, 'rlowess');
    M_L_Trans = smooth(1:frames(i,1), M_L_Trans, 'rlowess');
%     F_E_Rot = smooth(1:frames(i,1), F_E_Rot, 'rlowess');
     ABD_ADD_Rot = smooth(1:frames(i,1), ABD_ADD_Rot, 'rlowess');
%     E_I_Rot = smooth(1:frames(i,1), E_I_Rot, 'rlowess');
    % Increase sampling frequency to 1kHz
    Freq = 1001;
    x = (RawData(:,1)-Start_frame(i,1))/(end_frame(i,1)-Start_frame(i,1))*100;X = linspace(0,100,Freq)';
    
    V_AP = interp1(x,A_P_Trans,X,'pchip');   V_PD = interp1(x,P_D_Trans,X,'pchip');
    V_ML = interp1(x,M_L_Trans,X,'pchip');   R_FE = interp1(x,F_E_Rot,X,'pchip');
    R_AbdAdd = interp1(x,ABD_ADD_Rot,X,'pchip');   R_EI = interp1(x,E_I_Rot,X,'pchip');

%     V_AP = spline(x,A_P_Trans,X);   V_PD = spline(x,P_D_Trans,X);
%     V_ML = spline(x,M_L_Trans,X);   R_FE = spline(x,F_E_Rot,X);
%     R_AbdAdd = spline(x,ABD_ADD_Rot,X);   R_EI = spline(x,E_I_Rot,X);
%     
%     V_AP = interpft(A_P_Trans,Freq);   V_PD = interpft(P_D_Trans,Freq);
%     V_ML = interpft(M_L_Trans,Freq);   R_FE = interpft(F_E_Rot,Freq);
%     R_AddAbd = interpft(ABD_ADD_Rot,Freq);   R_IE = interpft(E_I_Rot,Freq);
    
%     A_P_Trans = smooth(1:frames(i,1), A_P_Trans, 'rlowess');
%     P_D_Trans = smooth(1:frames(i,1), P_D_Trans, 'rlowess');
%     M_L_Trans = smooth(1:frames(i,1), M_L_Trans, 'rlowess');
%     F_E_Rot = smooth(1:frames(i,1), F_E_Rot, 'rlowess');
%     ABD_ADD_Rot = smooth(1:frames(i,1), ABD_ADD_Rot, 'rlowess');
%     E_I_Rot = smooth(1:frames(i,1), E_I_Rot, 'rlowess');

    % Decimate sampling frequency to 100Hz
    V{1,1}(:,i) = V_AP(1:(size(V_AP)-1)/100:Freq,1);  
    V{2,1}(:,i) = V_PD(1:(size(V_AP)-1)/100:Freq,1);
    V{3,1}(:,i) = V_ML(1:(size(V_AP)-1)/100:Freq,1);  % Line 123 = AP PD ML
    R{1,1}(:,i) = R_FE(1:(size(V_AP)-1)/100:Freq,1);  
    R{2,1}(:,i) = R_AbdAdd(1:(size(V_AP)-1)/100:Freq,1);
    R{3,1}(:,i) = R_EI(1:(size(V_AP)-1)/100:Freq,1);  % Line 123 = FE AbdAdd EI
end

for i=1:3
    for k = 1:101
        mean_V(k,i) = mean(V{i,1}(k,:),2);
        mean_R(k,i) = mean(R{i,1}(k,:),2);
        std_V(k,i) = std(V{i,1}(k,:),0,2);
        std_R(k,i) = std(R{i,1}(k,:),0,2);
    end
end

 save('SN-StairUp-kinematic-pchip.mat','R','V','mean_V','mean_R','std_V','std_R', 'frames', 'Start_frame');


