SN_name='SN_Nor_individual_MedLat_contact';
MP_name='MP_Nor_individual_MedLat_contact';

SN= load (SN_name,'LatContactP_Mean','MedContactP_Mean');
MP= load (MP_name,'LatContactP_Mean','MedContactP_Mean');

for i=1:size(SN.LatContactP_Mean{1},1) % subject num
    for j=1:size(SN.LatContactP_Mean,1) % flexion angle
SN.LatCon{1,1}(j,i)=SN.LatContactP_Mean{j}(i,1);
SN.LatCon{2,1}(j,i)=SN.LatContactP_Mean{j}(i,2);
SN.LatCon{3,1}(j,i)=SN.LatContactP_Mean{j}(i,3);
SN.MedCon{1,1}(j,i)=SN.MedContactP_Mean{j}(i,1);
SN.MedCon{2,1}(j,i)=SN.MedContactP_Mean{j}(i,2);
SN.MedCon{3,1}(j,i)=SN.MedContactP_Mean{j}(i,3);
    end
end

for i=1:size(MP.LatContactP_Mean{1},1) % subject num
    for j=1:size(MP.LatContactP_Mean,1) % flexion angle
MP.LatCon{1,1}(j,i)=MP.LatContactP_Mean{j}(i,1);
MP.LatCon{2,1}(j,i)=MP.LatContactP_Mean{j}(i,2);
MP.LatCon{3,1}(j,i)=MP.LatContactP_Mean{j}(i,3);
MP.MedCon{1,1}(j,i)=MP.MedContactP_Mean{j}(i,1);
MP.MedCon{2,1}(j,i)=MP.MedContactP_Mean{j}(i,2);
MP.MedCon{3,1}(j,i)=MP.MedContactP_Mean{j}(i,3);
    end
end

for i=1:10
    count_i=1;
    for j=i:10
        index=55-(12-i)*(11-i)/2+count_i;
        SN_Med_AP_ROM(index,:)=max(SN.MedCon{1}((i-1)*2+1:j*2+1,:))-min(SN.MedCon{1}((i-1)*2+1:j*2+1,:));
        SN_Lat_AP_ROM(index,:)=max(SN.LatCon{1}((i-1)*2+1:j*2+1,:))-min(SN.LatCon{1}((i-1)*2+1:j*2+1,:));
        
        MP_Med_AP_ROM(index,:)=max(MP.MedCon{1}((i-1)*2+1:j*2+1,:))-min(MP.MedCon{1}((i-1)*2+1:j*2+1,:));
        MP_Lat_AP_ROM(index,:)=max(MP.LatCon{1}((i-1)*2+1:j*2+1,:))-min(MP.LatCon{1}((i-1)*2+1:j*2+1,:));
        ROM_Name{index,1}=[num2str((i-1)*10+0),'-',num2str(j*10+0)];
        count_i=count_i+1;
    end
end


for i=1:size(MP_Med_AP_ROM,1)
[P_MedAP_ROM(i,1),h_MedAP_ROM(i,1),~]=ranksum(SN_Med_AP_ROM(i,:)',MP_Med_AP_ROM(i,:)','tail','both','alpha',0.05,'method','exact');
[P_LatAP_ROM(i,1),h_LatAP_ROM(i,1),~]=ranksum(SN_Lat_AP_ROM(i,:)',MP_Lat_AP_ROM(i,:)','tail','both','alpha',0.05,'method','exact');
end