
% ��ȡ�������ͼ���������е�4��networkͼ����ע�ϸ��Ե�����
% ����ʱ��Ҫ���hitsz_gretna_4PlotNetwork���������ͳ���������ͳ�Ʒ���ͼ���Զ������ڵ�ǰ·����
% 2016-11-06(update 2017-04-04 by Challen)

% ��Ҫ�Զ�������ļ�·����ѡȡ�����ļ�
clc
clear
%ѡ�����Է�����
num_G=4;

%�ֱ�ȷ��G1��G2��Network Analysis�������txt���ļ�λ��
pathname_G1 = 'G:\��謿���������\SCD-NC\1SCD_network';
pathname_G2 = 'G:\��謿���������\aMCI-NC\aMCI_network';
pathname_G3 = 'G:\��謿���������\AD-NC\AD_network';
pathname_G4 = 'G:\��謿���������\SCD-NC\NC_network';


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

dirs_G3=dir([pathname_G3, '\*.txt']);
dircell_G3=struct2cell(dirs_G3)' ;
filenames_G3=dircell_G3(:,1);
file_path_G3=fullfile(pathname_G3,filenames_G3); %��������������ȫ·��

% ��ȡG3������       

dirs_G4=dir([pathname_G4, '\*.txt']);
dircell_G4=struct2cell(dirs_G4)' ;
filenames_G4=dircell_G4(:,1);
file_path_G4=fullfile(pathname_G4,filenames_G4); %��������������ȫ·��

% ��ȡPֵ����       
dirs_P=dir([pathname_P, '\*.txt']);
dircell_P=struct2cell(dirs_P)' ;
filenames_P=dircell_P(:,1);
file_path_P=fullfile(pathname_P,filenames_P); %��������������ȫ·��


% ����PlotNetwork������ͼ������
for i=1:length(filenames_P)
    G1=load(char(file_path_G1(i)));
    G2=load(char(file_path_G2(i)));
    G3=load(char(file_path_G3(i)));
    G4=load(char(file_path_G4(i)));
    y=hitsz_gretna_4PlotNetwork(Pvalue,G1,G2,G3,G4);   
    
    savename=char(filenames_P(i));
    savename(end-3:end)=[]; % ȥ���ļ����еġ�.txt��
    print(y, '-dpng', savename); % �����������ͼ�ڵ�ǰĿ¼
    close gcf
   
end
