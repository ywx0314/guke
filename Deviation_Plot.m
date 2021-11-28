function Deviation_Plot( x, y, y_std)
%DIVIATION_PLOT abstract
%   Input: x - XData, which is an N×1 vector;
%          y - YData, which is an N×M matrix, and M<=6;
%          y_std - YstdData, which is a matrix with similar scale to y;
pColor = {[0 1 0],[1 0 0],[0 0 1],[1 1 0],[1 0 1],[0 1 1]};
    
if size(y,2)>6
    warming('输入因变量列数超过6列，请调整输入后重新调用！');
end
for i = 1:size(y,2)
    plot([0 max(x)],[0 0],'k','linewidth',0.5);  hold on;
    plot(x,y(:,i),'Color', pColor{i}, 'LineWidth', 2); 
    plot(x,y(:,i),'Color', pColor{i}, 'LineWidth', 2); 
    x_edge = kron(x, [1;1]);
    y_edge = reshape([y(:,i)'+y_std(:,i)';y(:,i)'-y_std(:,i)'],[2*length(x),1]);
    vertices = [x_edge, y_edge];
    for k = 1:2*length(x)-2
        faces(k,:) = [k k+1 k+2]; 
    end
    patch('vertices',vertices,'faces',faces,'edgecolor','none','facealpha',0.25,'facecolor',pColor{i});
end
end

