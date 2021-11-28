function handles = AutoStitch(handles,Imode,Iprospect)

if handles.ImNum < 2,
    fprintf('Image_Number = %d, NEED NOT to do Stitching. \n',handles.ImNum);
    return;
end
tic;
wIm = handles.RawIm{1};
Index = zeros(handles.ImNum-1,4);
try
    xDoc = xmlread('conf.xml');
    Node = xDoc.getElementsByTagName('iso');
    para = Node.item(0).getFirstChild.getData;
    iso = str2double(para);
    Node = xDoc.getElementsByTagName('di');
    para = Node.item(0).getFirstChild.getData;
    di = str2double(para);
catch
    iso = 412;	%433-434 for 275mm system setting.
    di = 100;%������ƥ��ķ�Χ
    warning('Not find the xml conf file!');
end
dj = 100;
tiC = zeros(di-(-di)+1,1);
tjC = zeros(1,dj-(-dj)+1);
tjCl = zeros(1,dj-(-dj)+1); % only for the left part image stitching
tjCr = zeros(1,dj-(-dj)+1); % only for the right part image stitching
for in = 1:(handles.ImNum-1),
    A = uint16(wIm); % A is Above/Anterior, or F for Front
    B = uint16(handles.RawIm{in+1}); % B is Below/Behind, or P for Posterior, or S for Subsequent
    [h1, ~] = size(A);
    [~, ~] = size(B);
    % ����ǲ�λ�ҵ�ǰͼ��û����֫ ����ƴ��ģʽ�Ǽ���ƴ�� ����ƴ����ȫ��ƴ�ӣ�����ǰͼ��û����֫���߷�֧1
    if (~Iprospect && in < handles.ImNum-1) || (Imode==2) || ((Imode==1) && (in < handles.ImNum-2)),
        for i = -di:5:di,%������ƥ�䲽��Ϊ5
            tA = A(h1-iso+i:end,:);%��ͼ�¶�
            tB = B(1:iso-i+1,:);%��ͼ�϶�
            tiC(i+di+1) = corr2(tA,tB);
        end
        [~,ii] = max(tiC);%ii������ض���������
        i = ii-(di+1);
        indh = h1-iso+i;%indhΪ��ض����ĺ�����λ��
        overlap = h1-indh+1; % overlap = iso-i+1  %ƴ�Ӳ��ֵ��غϸ߶�
        if (i==-di || i==di),
            fprintf('indh = %d may need attention. \n',indh);
            %             warning('Maybe unreasonable index!'); % disp('Maybe unreasonable index!');
        end
        % j<0,��ͼ�����ұߵ�abs(j)���֣���ͼ������ߵ�abs(j)���֣�j>0,��֮������΢����Ѱ����ƥ���������λ��
        for j = -dj:dj,
            tA = A(indh:end,(j+abs(j))/2+1:end+(j-abs(j))/2);
            tB = B(1:iso-i+1,(abs(j)-j)/2+1:end-(abs(j)+j)/2);
            tjC(j+dj+1) = corr2(tA,tB);
        end
        %     % if one find it difficult for indexing above, he could also do as follow:
        %     for j = -dj:dj,
        %         tA = A(indh:end,j+dj+1:w1+j-dj);
        %         tB = B(1:iso-i+1,dj-j+1:w1-j-dj);
        %         tjC(j+dj+1) = corr2(tA,tB);
        %     end
        [~,jj] = max(tjC);
        j = jj-(dj+1);
        indv = (jj-(dj+1));%indvΪ��ض�����������λ�ã������A��
        if (j==-dj || j==dj),
            fprintf('indv = %d may need attention. \n',indv);
            %             warning('Maybe unreasonable index!'); % disp('Maybe unreasonable index!');
        end
        % ���indv<0,��ô��ͼ�����ұ�width-abs(indv)���֣�Ϊ�˺�ԭͼ���һ�£�����ˮƽ����ת���룻
        if indv<0,
            %             Bnew = [B(:,-indv+1:end),uint16(ones(h2,-indv)*4096*0.9)]; %note that uint16 and 4096
            Bnew = [B(:,-indv+1:end),flip(B(:,end+indv+1:end),2)];%����y�ᷭת
        else
            %             Bnew = [uint16(ones(h2,indv)*4096*0.9),B(:,1:end-indv)];
            Bnew = [flip(B(:,1:indv),2),B(:,1:end-indv)];
        end
        
        k = mean2(double(A(indh:end,:)))/mean2(double(Bnew(1:overlap,:)));%kΪҪƴ�Ӳ���A/Bnewƽ���Ҷ�ֵ��
        wIm = [A(1:indh,:); Bnew*k]; %  wIm = [A; Bnew(overlap+1:end,:)*k];��ȥA���ص����֣�Bnew��ɫ��ƴ��
        % ��ʼ�ں��㷨����������
        for i = 1:overlap,
            r = (i-1)/(overlap-1);
            wIm(indh+i-1,:) = (1-r)*A(indh+i-1,:) + r*Bnew(i,:)*k; %wIm�ںϹ����ͼ�񣬲�����ȫ�����֫
            % wIm(indh+i-1,:) = (1-r)*A(indh+i-1,:) + r*Bnew(i,:);
        end
        Index(in,:) = [indh,indv,indv,k];%in Ϊͼ������-1��index����ÿ��ƴ����Ϣ
    % ǣ�浽���ȣ��߷�֧2
    else
        % ��λ������������histogram���
        if ~Iprospect
            h=size(B,1);
            nB=B(0.3*h:0.8*h,:);
            img_vert_projection = mean(nB,1);%�����һ��ͼ��ÿ�о�ֵ
            img_vert_projection_copy = img_vert_projection;
            img_vert_projection_copy(:,1:end/2) = 0;%��ֵ���߹���
            img_vert_projection_copy(:,0.9*end:end) = 0;
            [~,separation_idx] = max(img_vert_projection_copy);%�Ҷ�ֵ��ߵĺ�����
            Al = wIm(:,1:separation_idx+100);%A1Ϊ��ͼ���ߣ��ԻҶ�ֵ���Ϊ��
            Ar = wIm(:,separation_idx+1-100:end);%ArΪ��ͼ�Ұ��
            Bl = handles.RawIm{in+1}(:,1:separation_idx+100);%B1Ϊ��ͼ���ߣ��ԻҶ�ֵ���Ϊ��
            Br = handles.RawIm{in+1}(:,separation_idx+1-100:end);
        %��λ���򵥴��м�����
        else
            Al = wIm(:,1:end/2+100); % Note: make sure the width of wIm, that is 'end' is EVEN number
            Ar = wIm(:,end/2+1-100:end);
            Bl = handles.RawIm{in+1}(:,1:end/2+100);
            Br = handles.RawIm{in+1}(:,end/2+1-100:end);
            separation_idx=(size(handles.RawIm{in+1},2))/2;
        end
        %ƥ������
        for i = -di:2:di,
            tA = wIm(h1-iso+i:end,:);
            tB = handles.RawIm{in+1}(1:iso-i+1,:);
            tiC(i+di+1) = corr2(tA,tB);
        end
        [~,ii] = max(tiC);
        i = ii-(di+1);
        indh = h1-iso+i;
        overlap = h1-indh+1; % overlap = iso-i+1
        if (i==-di || i==di),
            fprintf('indh = %d may need attention. \n',indh);
            %             warning('Maybe unreasonable index!'); % disp('Maybe unreasonable index!');
        end
        %         tic;    % disp('ͬʱ��������ƴ��λ�ã�');
           %ƥ������
        for j = -dj:dj, % here the left and right positioning is simultaneously, also can being respectively
            tA = Al(indh:end,(j+abs(j))/2+1:end+(j-abs(j))/2);
            tB = Bl(1:iso-i+1,(abs(j)-j)/2+1:end-(abs(j)+j)/2);
            tjCl(j+dj+1) = corr2(tA,tB);
            tA = Ar(indh:end,(j+abs(j))/2+1:end+(j-abs(j))/2);
            tB = Br(1:iso-i+1,(abs(j)-j)/2+1:end-(abs(j)+j)/2);
            tjCr(j+dj+1) = corr2(tA,tB);
        end
        [~,jjl] = max(tjCl);
        [~,jjr] = max(tjCr);
        jl = jjl-(dj+1);
        jr = jjr-(dj+1);
        indvl = (jjl-(dj+1));
        indvr = (jjr-(dj+1));
        %         toc;
        % % only to test the correlation calculation respectively, if the calculation time different.
        %{
        tic;    % disp('�Ⱥ��������ƴ��λ�ã�');
        for j = -dj:dj,
            tA = Al(indh:end,(j+abs(j))/2+1:end+(j-abs(j))/2);
            tB = Bl(1:iso-i+1,(abs(j)-j)/2+1:end-(abs(j)+j)/2);
            tjCl(j+dj+1) = corr2(tA,tB);
        end
        [~,jjl] = max(tjCl);
        jl = jjl-(dj+1);
        indvl = (jjl-(dj+1));
        for j = -dj:dj,
            tA = Ar(indh:end,(j+abs(j))/2+1:end+(j-abs(j))/2);
            tB = Br(1:iso-i+1,(abs(j)-j)/2+1:end-(abs(j)+j)/2);
            tjCr(j+dj+1) = corr2(tA,tB);
        end
        [~,jjr] = max(tjCr);
        jr = jjr-(dj+1);
        indvr = (jjr-(dj+1));
        toc;
        %}
        if (jl==-dj||jl==dj)||(jr==-dj||jr==dj),
            fprintf('indvl = %d ;',indvl); fprintf('indvr = %d ; may need attention.\n',indvr);
            %             warning('Maybe unreasonable index!'); % disp('Maybe unreasonable index!');
        end
        
         for i = 1:(200+indvl-indvr),
            r = (i-1)/(200+indvl-indvr-1); % here r is ratio NOT for right
            Bl(:,separation_idx+indvr-100+i-1) = (1-r)*Bl(:,separation_idx+indvr-100+i-1) + r*Br(:,i);
        end
        
        if indvl<0,
            %             Blnew = [Bl(:,-indvl+1:end),uint16(ones(h2,-indvl)*4096*0.9)]; %note that uint16 and 4096
            Blnew = Bl(:,-indvl+1:end);%Blnew = [Bl(:,-indvl+1:end),flip(Bl(:,end+indvl+1:end),2)];
            %             Blnew = imresize(Bl(:,-indvl+1:end),size(Bl)); % CAN NOT BE USED
            %             Bnew = [B(:,-indvl+1:end),uint16(ones(h2,-indvl)*4096*0.9)]; % aim to calculate the k value
        else
            %             Blnew = [uint16(ones(h2,indvl)*4096*0.9),Bl(:,1:end-indvl)];
            Blnew = [Bl(:,1:indvl),Bl(:,1:end)];%Blnew = [flip(Bl(:,1:indvl),2),Bl(:,1:end-indvl)];
            %             Blnew = imresize(Bl(:,1:end-indvl),size(Bl)); % CAN NOT BE USED
            %             Bnew = [uint16(ones(h2,indvl)*4096*0.9),B(:,1:end-indvl)]; % aim to calculate the k value
        end
        if indvr<0,
            %             Brnew = [Br(:,-indvr+1:end),uint16(ones(h2,-indvr)*4096*0.9)]; %note that uint16 and 4096
            Brnew = [Br(:,200+indvl-indvr+1:end),Br(:,end+indvr+1:end)];%Brnew = [Br(:,-indvr+1:end),flip(Br(:,end+indvr+1:end),2)];
            %             Brnew = imresize(Br(:,-indvr+1:end),size(Br)); % CAN NOT BE USED
        else
            %             Brnew = [uint16(ones(h2,indvr)*4096*0.9),Br(:,1:end-indvr)];
            Brnew = Br(:,200+indvl-indvr+1:end-indvr);%Brnew = [flip(Br(:,1:indvr),2),Br(:,1:end-indvr)];
            %             Brnew = imresize(Br(:,1:end-indvr),size(Br)); % CAN NOT BE USED
        end
        Bnew=[Blnew,Brnew];
        k = mean2(double(A(indh:end,:)))/mean2(double(Bnew(1:overlap,:)));
        
        wIm = [A(1:indh,:); Bnew*k];
        
        for i = 1:overlap,
            r = (i-1)/(overlap-1); % here r is ratio NOT for right
            wIm(indh+i-1,:) = (1-r)*A(indh+i-1,:) + r*Bnew(i,:)*k;
        end
        Index(in,:) = [indh,indvl,indvr,k];
    end
end
toc;
wIm_c = wIm;
wIm = wIm_c;
handles.wIm = wIm;
% ���ƴ��
for iiii = 1:size(Index,1)
    lower = max(1,Index(iiii,1)-2);
    upper = min(size(wIm,1),Index(iiii,1)+2);
    wIm(lower:upper,:) = 800;
end
axes(handles.axes1);
cla
imshow(imcomplement(wIm),[]);%����
% hold on
% for line_index = 1:size(Index,1) %��ƴ���� Draw stich line
% plot([1,size(wIm,2)],[Index(line_index,1) Index(line_index,1)],'-','color',[105 105 105]/255)
% end
% hold off
fprintf('-------------------------------------------------------- \n');
fprintf('result of parameters: \n');
disp(num2str(Index));
fprintf('\n \n');

filestr = strcat(handles.DCMList{1}(1:16),handles.DCMList{1}(end-3:end));
cpath =cd;
if ~exist('output','dir')
    mkdir('output')
end
dicomwrite(imcomplement(wIm),fullfile(cpath,'output',filestr));
timestr = datestr(now,31);
dlmwrite('log.log',timestr,'delimiter','','newline','pc','-append');
dlmwrite('log.log','--------------------------------------------------------','delimiter','','newline','pc','-append');
dlmwrite('log.log','result of parameters:','delimiter','','newline','pc','-append');
dlmwrite('log.log',num2str(Index),'delimiter','','newline','pc','-append');
dlmwrite('log.log',' ','newline','pc','-append');
dlmwrite('log.log',' ','newline','pc','-append');
end



