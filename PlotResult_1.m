load('SN-StairUp-kinematic-pchip.mat');
Subject_num = size(V{1},2);
colorSet =num2cell(jet(Subject_num),2);
%colorSet = {[1 0 0]; [0 1 0]; [0 0 1]; [1 1 0]; [0 1 1]; [1 0.5 0]};
R_title = {'Flex(+)/EXT(-)'; 'ABD(+)/ADD(-)'; 'ER(+)/IR(-)'};
V_title = {'A(+)/P(-)'; 'P(+)/D(-)'; 'M(+)/L(-)'};
for k = 1:3
    subplot(2,3,k);
    for i = 1:Subject_num
        plot(0:1:size(R{1},1)-1,R{k}(:,i), '-', 'linewidth', 2, 'Color', colorSet{i}); hold on;
        %text(50,R{k}(50,i),num2str(i));
        Legend_label{i} = ['subject ', num2str(i)]; 
    end
    xlabel('Gait(%)');
    ylabel('Angle(deg)');
    legend(Legend_label, 'Location', 'best'); 
    title(['Femoral and Tibial components ',R_title{k},' Rotations'], 'Interpreter', 'none');
end

for k = 4:6
    subplot(2,3,k);
    for i = 1:Subject_num
        plot(0:1:size(V{1},1)-1,V{k-3}(:,i), '-', 'linewidth', 2, 'Color', colorSet{i}); hold on;
        Legend_label{i} = ['subject ', num2str(i)]; 
    end
    xlabel('Gait(%)');
    ylabel('Translation(mm)');
    legend(Legend_label, 'Location', 'best'); 
    title(['Femoral and Tibial components ',V_title{k-3},' Translations'], 'Interpreter', 'none');
end