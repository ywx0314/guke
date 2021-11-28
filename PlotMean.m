load SN-StairUp-kinematic-pchip;
x = [1:1:101]';
% Deviation_Plot(x, mean_R(:,3),std_R(:,3));
subplot(2,3,1);
Deviation_Plot(x, mean_R(:,1),std_R(:,1));
axis([0 100 -inf inf]);
set(gcf,'unit','centimeters','position',[10 10 20 10],'color',[1 1 1]); 
set(gca,'fontsize',15,'fontname','Times New Roman','linewidth',1);
xlabel('StairUp cycle (0   100)','fontsize',18,'fontname','Times New Roman');
ylabel({'¡ûExtension         Flexion¡ú';'[deg]'},'fontsize',18, 'fontname','Times New Roman');

subplot(2,3,2);
Deviation_Plot(x, mean_R(:,2),std_R(:,2));
axis([0 100 -10 10]);
set(gcf,'unit','centimeters','position',[10 10 20 10],'color',[1 1 1]); 
set(gca,'fontsize',15,'fontname','Times New Roman','linewidth',1);
xlabel('StairUp cycle (0   100)','fontsize',18,'fontname','Times New Roman');
ylabel({'¡ûAdduction         Abduction¡ú';'[deg]'},'fontsize',18, 'fontname','Times New Roman');

subplot(2,3,3);
Deviation_Plot(x, mean_R(:,3),std_R(:,3));
axis([0 100 -15 6]);
set(gcf,'unit','centimeters','position',[10 10 20 10],'color',[1 1 1]); 
set(gca,'fontsize',15,'fontname','Times New Roman','linewidth',1);
xlabel('StairUp cycle (0   100)','fontsize',18,'fontname','Times New Roman');
ylabel({'¡ûI Rotation        E Rotation¡ú';'[deg]'},'fontsize',18, 'fontname','Times New Roman');

subplot(2,3,4);
Deviation_Plot(x, mean_V(:,1),std_V(:,1));
axis([0 100 -10 10]);
set(gcf,'unit','centimeters','position',[10 10 20 10],'color',[1 1 1]); 
set(gca,'fontsize',15,'fontname','Times New Roman','linewidth',1);
xlabel('StairUp cycle (0   100)','fontsize',18,'fontname','Times New Roman');
ylabel({'¡ûPosterior        Anterior¡ú';'[mm]'},'fontsize',18, 'fontname','Times New Roman');

subplot(2,3,5);
Deviation_Plot(x, mean_V(:,2),std_V(:,2));
axis([0 100 25 35]);
set(gcf,'unit','centimeters','position',[10 10 20 10],'color',[1 1 1]); 
set(gca,'fontsize',15,'fontname','Times New Roman','linewidth',1);
xlabel('StairUp cycle (0   100)','fontsize',18,'fontname','Times New Roman');
ylabel({'¡ûProximal         Distal¡ú';'[mm]'},'fontsize',18, 'fontname','Times New Roman');

subplot(2,3,6);
Deviation_Plot(x, mean_V(:,3),std_V(:,3));
axis([0 100 -10 10]);
set(gcf,'unit','centimeters','position',[10 10 20 10],'color',[1 1 1]); 
set(gca,'fontsize',15,'fontname','Times New Roman','linewidth',1);
xlabel('StairUp cycle (0   100)','fontsize',18,'fontname','Times New Roman');
ylabel({'¡ûLateral         Medial¡ú';'[mm]'},'fontsize',18, 'fontname','Times New Roman');