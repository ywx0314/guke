SN_name='SN_gait_KinReaults_RT_VT';
MP_name='MP_Gait_KinResults_FGloble';

SN= load (SN_name,'mean_R','mean_V','std_R','std_V');
MP= load (MP_name,'mean_R','mean_V','std_R','std_V');


x = [1:1:101]';
% Deviation_Plot(x, mean_R(:,3),std_R(:,3));
subplot(2,3,1);
Deviation_Plot(x, [SN.mean_R(:,1),MP.mean_R(:,1)],[SN.std_R(:,1),MP.std_R(:,1)]);
axis([0 100 -inf inf]);
h=get(gca);
set(gcf,'unit','centimeters','position',[10 10 20 10],'color',[1 1 1]); 
set(gca,'fontsize',15,'fontname','Times New Roman','linewidth',1);
xlabel('gait cycle (0   100)','fontsize',18,'fontname','Times New Roman');
ylabel({'¡ûExtension         Flexion¡ú';'[deg]'},'fontsize',18, 'fontname','Times New Roman');
%legend( h([2,6],'MP-gait','SN-gait'),'Location', 'best'); 
legend ( [h.Children(1),h.Children(4)],'MP-gait','SN-gait','Location', 'best');

subplot(2,3,2);
Deviation_Plot(x, [SN.mean_R(:,2),MP.mean_R(:,2)],[SN.std_R(:,2),MP.std_R(:,2)]);
axis([0 100 -10 10]);
set(gcf,'unit','centimeters','position',[10 10 20 10],'color',[1 1 1]); 
set(gca,'fontsize',15,'fontname','Times New Roman','linewidth',1);
xlabel('gait cycle (0   100)','fontsize',18,'fontname','Times New Roman');
ylabel({'¡ûadduction         Abduction¡ú';'[deg]'},'fontsize',18, 'fontname','Times New Roman');

subplot(2,3,3);
Deviation_Plot(x, [-SN.mean_R(:,3),-MP.mean_R(:,3)],[SN.std_R(:,3),MP.std_R(:,3)]);
axis([0 100 -10 10]);
set(gcf,'unit','centimeters','position',[10 10 20 10],'color',[1 1 1]); 
set(gca,'fontsize',15,'fontname','Times New Roman','linewidth',1);
xlabel('gait cycle (0   100)','fontsize',18,'fontname','Times New Roman');
ylabel({'¡ûE Rotation        I Rotation¡ú';'[deg]'},'fontsize',18, 'fontname','Times New Roman');

subplot(2,3,4);
Deviation_Plot(x, [SN.mean_V(:,1),MP.mean_V(:,1)],[SN.std_V(:,1),MP.std_V(:,1)]);
axis([0 100 -10 4]);
set(gcf,'unit','centimeters','position',[10 10 20 10],'color',[1 1 1]); 
set(gca,'fontsize',15,'fontname','Times New Roman','linewidth',1);
xlabel('gait cycle (0   100)','fontsize',18,'fontname','Times New Roman');
ylabel({'¡ûPosterior        Anterior¡ú';'[mm]'},'fontsize',18, 'fontname','Times New Roman');

subplot(2,3,5);
Deviation_Plot(x, [SN.mean_V(:,2),MP.mean_V(:,2)],[SN.std_V(:,2),MP.std_V(:,2)]);
axis([0 100 25 40]);
set(gcf,'unit','centimeters','position',[10 10 20 10],'color',[1 1 1]); 
set(gca,'fontsize',15,'fontname','Times New Roman','linewidth',1);
xlabel('gait cycle (0   100)','fontsize',18,'fontname','Times New Roman');
ylabel({'¡ûProximal         Distal¡ú';'[mm]'},'fontsize',18, 'fontname','Times New Roman');

subplot(2,3,6);
Deviation_Plot(x, [SN.mean_V(:,3),MP.mean_V(:,3)],[SN.std_V(:,3),MP.std_V(:,3)]);
axis([0 100 -10 4]);
set(gcf,'unit','centimeters','position',[10 10 20 10],'color',[1 1 1]); 
set(gca,'fontsize',15,'fontname','Times New Roman','linewidth',1);
xlabel('gait cycle (0   100)','fontsize',18,'fontname','Times New Roman');
ylabel({'¡ûLateral         Medial¡ú';'[mm]'},'fontsize',18, 'fontname','Times New Roman');