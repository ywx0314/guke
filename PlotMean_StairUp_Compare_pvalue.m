SN_name='SN-StairUp-kinematic-pchip';
MP_name='MP-StairUp-kinematic-pchip';

SN= load (SN_name,'mean_R','mean_V','std_R','std_V','R','V');
MP= load (MP_name,'mean_R','mean_V','std_R','std_V','R','V');

P_R=zeros(size(SN.mean_R));P_V=zeros(size(SN.mean_R));
h_R=zeros(size(SN.mean_R));h_V=zeros(size(SN.mean_R));

for i=1:size(SN.mean_R,1)
    [P_R(i,1),h_R(i,1),~] = ranksum(SN.R{1}(i,:),MP.R{1}(i,:),'tail','both','alpha',0.05,'method','exact');
    [P_R(i,2),h_R(i,2),~] = ranksum(SN.R{2}(i,:),MP.R{2}(i,:),'tail','both','alpha',0.05,'method','exact');
    [P_R(i,3),h_R(i,3),~] = ranksum(SN.R{3}(i,:),MP.R{3}(i,:),'tail','both','alpha',0.05,'method','exact');
    [P_V(i,1),h_V(i,1),~] = ranksum(SN.V{1}(i,:),MP.V{1}(i,:),'tail','both','alpha',0.05,'method','exact');
    [P_V(i,2),h_V(i,2),~] = ranksum(SN.V{2}(i,:),MP.V{2}(i,:),'tail','both','alpha',0.05,'method','exact');
    [P_V(i,3),h_V(i,3),~] = ranksum(SN.V{3}(i,:),MP.V{3}(i,:),'tail','both','alpha',0.05,'method','exact');

end
h_R=logical(h_R);h_V=logical(h_V);

x = [0:1:100]';
% Deviation_Plot(x, mean_R(:,3),std_R(:,3));
subplot(2,3,1);
Deviation_Plot(x, [SN.mean_R(:,1),MP.mean_R(:,1)],[SN.std_R(:,1),MP.std_R(:,1)]);
axis([0 100 -10 80]);
h=get(gca);
set(gcf,'unit','centimeters','position',[10 10 20 10],'color',[1 1 1]); 
set(gca,'fontsize',15,'fontname','Times New Roman','linewidth',1);
xlabel('StairUp cycle ','fontsize',16,'fontname','Times New Roman');
ylabel({'¡ûExtension         Flexion¡ú';'[deg]'},'fontsize',16, 'fontname','Times New Roman');
%legend( h([2,6],'MP-gait','SN-gait'),'Location', 'best'); 
l2= plot([60 60],[-10 85],'--k','linewidth',0.5); 
plot(x(h_R(1:end-1,1),1),-10*ones(size(x(h_R(1:end-1,1),1),1),1),'sr', 'MarkerSize',6,'MarkerFaceColor','r')
legend ( [h.Children(1),h.Children(4)],'MP','PS','Location', 'best');

subplot(2,3,2);
Deviation_Plot(x, [SN.mean_R(:,2),MP.mean_R(:,2)],[SN.std_R(:,2),MP.std_R(:,2)]);
axis([0 100 -10 10]);
set(gcf,'unit','centimeters','position',[10 10 20 10],'color',[1 1 1]); 
set(gca,'fontsize',15,'fontname','Times New Roman','linewidth',1);
xlabel('StairUp cycle ','fontsize',16,'fontname','Times New Roman');
ylabel({'¡ûAdduction      Abduction¡ú';'[deg]'},'fontsize',16, 'fontname','Times New Roman');
l2= plot([60 60],[-10 65],'--k','linewidth',0.5); 
plot(x(h_R(1:end-1,2),1),-10*ones(size(x(h_R(1:end-1,2),1),1),1),'sr', 'MarkerSize',6,'MarkerFaceColor','r')

subplot(2,3,3);
Deviation_Plot(x, [-SN.mean_R(:,3),-MP.mean_R(:,3)],[SN.std_R(:,3),MP.std_R(:,3)]);
axis([0 100 -10 15]);
set(gcf,'unit','centimeters','position',[10 10 20 10],'color',[1 1 1]); 
set(gca,'fontsize',15,'fontname','Times New Roman','linewidth',1);
xlabel('StairUp cycle ','fontsize',16,'fontname','Times New Roman');
ylabel({'¡ûE Rotation      I Rotation¡ú';'[deg]'},'fontsize',16, 'fontname','Times New Roman');
l2= plot([60 60],[-10 65],'--k','linewidth',0.5); 
plot(x(h_R(1:end-1,3),1),-10*ones(size(x(h_R(1:end-1,3),1),1),1),'sr', 'MarkerSize',6,'MarkerFaceColor','r')

subplot(2,3,4);
Deviation_Plot(x, [SN.mean_V(:,1),MP.mean_V(:,1)],[SN.std_V(:,1),MP.std_V(:,1)]);
axis([0 100 -10 5]);
set(gcf,'unit','centimeters','position',[10 10 20 10],'color',[1 1 1]); 
set(gca,'fontsize',15,'fontname','Times New Roman','linewidth',1);
xlabel('StairUp cycle ','fontsize',16,'fontname','Times New Roman');
ylabel({'¡ûPosterior      Anterior¡ú';'[mm]'},'fontsize',16, 'fontname','Times New Roman');
l2= plot([60 60],[-10 65],'--k','linewidth',0.5); 
plot(x(h_V(1:end-1,1),1),-10*ones(size(x(h_V(1:end-1,1),1),1),1),'sr', 'MarkerSize',6,'MarkerFaceColor','r')

subplot(2,3,5);
Deviation_Plot(x, [SN.mean_V(:,2),MP.mean_V(:,2)],[SN.std_V(:,2),MP.std_V(:,2)]);
axis([0 100 25 40]);
set(gcf,'unit','centimeters','position',[10 10 20 10],'color',[1 1 1]); 
set(gca,'fontsize',15,'fontname','Times New Roman','linewidth',1);
xlabel('StairUp cycle ','fontsize',16,'fontname','Times New Roman');
ylabel({'¡ûDistal       Proximal¡ú';'[mm]'},'fontsize',16, 'fontname','Times New Roman');
l2= plot([60 60],[-10 65],'--k','linewidth',0.5); 
plot(x(h_V(1:end-1,2),1),25*ones(size(x(h_V(1:end-1,2),1),1),1),'sr', 'MarkerSize',6,'MarkerFaceColor','r')

subplot(2,3,6);
Deviation_Plot(x, [SN.mean_V(:,3),MP.mean_V(:,3)],[SN.std_V(:,3),MP.std_V(:,3)]);
axis([0 100 -10 5]);
set(gcf,'unit','centimeters','position',[10 10 20 10],'color',[1 1 1]); 
set(gca,'fontsize',15,'fontname','Times New Roman','linewidth',1);
xlabel('StairUp cycle ','fontsize',16,'fontname','Times New Roman');
ylabel({'¡ûLateral       Medial¡ú';'[mm]'},'fontsize',16, 'fontname','Times New Roman');
l2= plot([60 60],[-10 65],'--k','linewidth',0.5); 
plot(x(h_V(1:end-1,3),1),-10*ones(size(x(h_V(1:end-1,3),1),1),1),'sr', 'MarkerSize',6,'MarkerFaceColor','r')
