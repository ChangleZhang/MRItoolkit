% ���������ͼ
% 2016-05-05
% Input:  Pvalue�Ǻ�׺_P.txt;G1��Group1���������txt��G2��Group2���������txt��G3��Group3���������txt
% Output: y�ǵ�ǰfig�ľ��



function y=hitsz_gretna_4PlotNetwork(G1,G2,G3,G4)

%��ȡ�ļ� (����AUC�ļ�)
% G1=load('H:\JMRI\output_NetworkAnalysis\G1\Results_NetworkSmallWorld\aEg.txt');
% G2=load('H:\JMRI\output_NetworkAnalysis\G2\Results_NetworkSmallWorld\aEg.txt');
% Pvalue=load('H:\JMRI\output_NetworkComp_withoutCor\NetsEg_none_P.txt');

%��ȡ�ļ� (����All_threshold�ļ�)
% G1=load('H:\JMRI\output_NetworkAnalysis\G1\Results_NetworkSmallWorld\Cp_All_Threshold.txt');
% G2=load('H:\JMRI\output_NetworkAnalysis\G2\Results_NetworkSmallWorld\Cp_All_Threshold.txt');
% Pvalue=load('H:\JMRI\output_NetworkComp_withoutCor\Cp_All_Threshold_P.txt');

%��ȡ�ļ� (����All_Node�ļ�)
% G1=load('H:\JMRI\output_NetworkAnalysis\G1\Results_NetworkSmallWorld\anodalCp_All_Node.txt');
% G2=load('H:\JMRI\output_NetworkAnalysis\G2\Results_NetworkSmallWorld\anodalCp_All_Node.txt');
% Pvalue=load('H:\JMRI\output_NetworkComp_withoutCor\anodalCp_All_Node_P.txt');

% �����𲻰�����G3
if nargin==3
    meanG1=mean(G1); stdG1=std(G1);%��G1���ֵ���׼��
    meanG2=mean(G2);  stdG2=std(G2);%��G2���ֵ���׼��
    Xaxis=0.05:0.01:0.4; %��ֵ������
    % ���mean�ǵ�ֵ������״ͼ��
    if length(meanG1)==1
        %��ͼ
        errorbar(0.5,meanG1,stdG1,'rx');hold on;
        errorbar(0.6,meanG2,stdG2,'bx');hold on;
        %��Pֵ���
       
        
    else
        %���Pvalue�ļ�ά�ȵ�����ֵ����ά�ȣ�����ֵͼ
        if length(Xaxis)==36
            plot(Xaxis,meanG1,'o-','color','r');hold on;
            plot(Xaxis,meanG2,'v-','color','b');hold on;
            legend('G1','G2');
            errorbar(Xaxis,meanG1,stdG1,'r');hold on;
            errorbar(Xaxis,meanG2,stdG2,'b');
            
            %��Pֵ���
            corr=zeros(1,length(Pvalue));
            full=[meanG1 meanG2];
            for i=1:length(Pvalue)
                if Pvalue(i)<0.05
                    corr(i)=min(full)-0.05;
                end
            end
            pos=find(Pvalue<0.05);
            plot(Xaxis(pos),corr(pos),'*','MarkerFaceColor','k');
            
        else %��nodeͼ
            plot(meanG1,'o-','color','r');hold on;
            plot(meanG2,'v-','color','b');hold on;
            legend('G1','G2');
            errorbar(meanG1,stdG1,'r');hold on;
            errorbar(meanG2,stdG2,'b');
            
            %��Pֵ���
            corr=zeros(1,length(Pvalue));
            full=[meanG1 meanG2];
            for i=1:length(Pvalue)
                if Pvalue(i)<0.05
                    corr(i)=min(full)-0.05;
                end
            end
            pos=find(Pvalue<0.05);
            plot(pos,corr(pos),'*','MarkerFaceColor','k');
        end
        
    end
% �������G3
else
    meanG1=mean(G1); stdG1=std(G1);%��G1���ֵ���׼��
    meanG2=mean(G2);  stdG2=std(G2);%��G2���ֵ���׼��
    meanG3=mean(G3);  stdG3=std(G3);%��G3���ֵ���׼��
    meanG4=mean(G4);  stdG4=std(G4);%��G3���ֵ���׼��
    Xaxis=0.05:0.01:0.4; %��ֵ������
    % ���mean�ǵ�ֵ������״ͼ��
    if length(meanG1)==1
        %��ͼ
        errorbar(0.5,meanG1,stdG1,'rx');hold on;
        errorbar(0.6,meanG2,stdG2,'bx');hold on;
        errorbar(0.7,meanG3,stdG3,'gx');hold on;
        errorbar(0.4,meanG4,stdG4,'kx');hold on;
        legend('SCD','aMCI','AD','NC');
        %��Pֵ���
%         if Pvalue <0.05
%             plot(0.6,max([meanG1,meanG2,meanG3])+max([stdG1,stdG2,stdG3]),'*','MarkerFaceColor','k');
%         end
        
    else
        %���Pvalue�ļ�ά�ȵ�����ֵ����ά�ȣ�����ֵͼ
        if length(meanG1)==36
            plot(Xaxis,meanG1,'o-','color','r');hold on;
            plot(Xaxis,meanG2,'v-','color','b');hold on;
            plot(Xaxis,meanG3,'s-','color','g');hold on;
            plot(Xaxis,meanG4,'^-','color','k');hold on;
            legend('SCD','aMCI','AD','NC');
            errorbar(Xaxis,meanG1,stdG1,'r');hold on;
            errorbar(Xaxis,meanG2,stdG2,'b');hold on;
            errorbar(Xaxis,meanG3,stdG3,'g');hold on;
            errorbar(Xaxis,meanG4,stdG4,'k');hold on;
            
%             %��Pֵ���
%             corr=zeros(1,length(Pvalue));
%             full=[meanG1 meanG2 meanG3];
%             for i=1:length(Pvalue)
%                 if Pvalue(i)<0.05
%                     corr(i)=min(full)-0.05;
%                 end
%             end
%             pos=find(Pvalue<0.05);
%             plot(Xaxis(pos),corr(pos),'*','MarkerFaceColor','k');
            
        else %��nodeͼ
            plot(meanG1,'o-','color','r');hold on;
            plot(meanG2,'v-','color','b');hold on;
            plot(meanG3,'s-','color','g');hold on;
            plot(meanG4,'^-','color','k');hold on;
            legend('SCD','aMCI','AD','NC');
            errorbar(meanG1,stdG1,'r');hold on;
            errorbar(meanG2,stdG2,'b');hold on;
            errorbar(meanG3,stdG3,'g');hold on;
            errorbar(meanG4,stdG4,'g');hold on;
            
%             %��Pֵ���
%             corr=zeros(1,length(Pvalue));
%             full=[meanG1 meanG2 meanG3];
%             for i=1:length(Pvalue)
%                 if Pvalue(i)<0.05
%                     corr(i)=min(full)-0.05;
%                 end
%             end
%             pos=find(Pvalue<0.05);
%             plot(pos,corr(pos),'*','MarkerFaceColor','k');
        end
        
    end
end

% return gcf
y=gcf;
