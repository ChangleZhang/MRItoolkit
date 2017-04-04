
% ��ȡ�������ͼ
% ����ʱ��Ҫ���hitsz_gretna_PlotNetwork���������ͳ���������ͳ�Ʒ���ͼ���Զ������ڵ�ǰ·����
% 2016-05-05

% ��Ҫ�Զ�������ļ�·����ѡȡ�����ļ�
clc
clear
%ѡ�����Է�����
num_G=3;

%�ֱ�ȷ��G1��G2��Network Analysis�������txt���ļ�λ��
pathname_G1 = 'C:\Users\Figo-workstation\Desktop\XH\D\ANA_RESULT_sparsity\Network_Analysis';
pathname_G2 = 'C:\Users\Figo-workstation\Desktop\XH\NC\ANA_RESULT_sparsity\Network_Analysis';
pathname_G3 = 'C:\Users\Figo-workstation\Desktop\XH\ND\ANA_RESULT_sparsity\Network_Analysis';
pathname_P='C:\Users\Figo-workstation\Desktop\XH\output_NetworkComp_withCor';

% ��ȡG1������       
dirs_G1=dir([pathname_G1, '\*.txt']);
dircell_G1=struct2cell(dirs_G1)' ;
filenames_G1=dircell_G1(:,1);
file_path_G1=fullfile(pathname_G1,filenames_G1); %��������������ȫ·��

% ��ȡG2������       
dirs_G2=dir([pathname_G2, '\*.txt']);
dircell_G2=struct2cell(dirs_G2)' ;
filenames_G2=dircell_G2(:,1);
file_path_G2=fullfile(pathname_G2,filenames_G2); %��������������ȫ·��

% ��ȡG3������       
if num_G==3
dirs_G3=dir([pathname_G3, '\*.txt']);
dircell_G3=struct2cell(dirs_G3)' ;
filenames_G3=dircell_G3(:,1);
file_path_G3=fullfile(pathname_G3,filenames_G3); %��������������ȫ·��
end

% ��ȡPֵ����       
dirs_P=dir([pathname_P, '\*.txt']);
dircell_P=struct2cell(dirs_P)' ;
filenames_P=dircell_P(:,1);
file_path_P=fullfile(pathname_P,filenames_P); %��������������ȫ·��


% ����PlotNetwork������ͼ������
for i=1:length(filenames_P)
    G1=load(char(file_path_G1(i)));
    G2=load(char(file_path_G2(i)));
    Pvalue=load(char(file_path_P(i)));
    if num_G==3
        G3=load(char(file_path_G3(i)));
        y=hitsz_gretna_PlotNetwork(Pvalue,G1,G2,G3);   
    else
    y=hitsz_gretna_PlotNetwork(Pvalue,G1,G2);   
    end
    savename=char(filenames_P(i));
    savename(end-3:end)=[]; % ȥ���ļ����еġ�.txt��
    print(y, '-dpng', savename); % �����������ͼ�ڵ�ǰĿ¼
    close gcf
   
end
