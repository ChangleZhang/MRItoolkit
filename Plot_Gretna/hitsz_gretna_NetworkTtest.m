%% hitsz_gretna_NetworkTtest_w.m
% ���������ͳ�Ʒ���unpaired t-test with covariates and FDR correction
% w means weighted network
% ��Ҫ�õ��ĳ��������gretna_TTest2.m fdr_bh.m
% Input: 
% covariates��<string> yes�������Э����,no��������Э����
% pathname1:<string> NC�������в����ļ�txt���ļ���·��; 
% pathname2:<string> PSD�������в����ļ�txt���ļ���·��; 
% file_path_c1:<string> NCЭ�����ļ�txt·��; 
% file_path_c2:<string> PSDЭ�����ļ�txt·��;
% OutputDir:<string> Pֵ���·��
% 
% Output:�����·��������txt��Pֵ�ļ�



%%
clc
clear
covariates='yes'; %yes�������Э����,no��������Э����

%ѡ��NetworkĿ¼

pathname1='H:\JMRI\CC_subnetwork\NetWork_FA_25\Analysis_NC'; %NC�������в����ļ�txt���ļ���·��
pathname2='H:\JMRI\CC_subnetwork\NetWork_FA_25\Analysis_PSD';%PSD�������в����ļ�txt���ļ���·��

file_path_c1='H:\JMRI\CC_subnetwork\Cov_NC.txt'; %NCЭ�����ļ�txt·��
file_path_c2='H:\JMRI\CC_subnetwork\Cov_PSD.txt'; %PSDЭ�����ļ�txt·��

OutputDir='E:\ML\matlab\GRETNA_1.2.1_release'; %Pֵ���·��

%��ȡNC��������ļ���
dirs1=dir([pathname1, '\*.txt']);
dircell1=struct2cell(dirs1)' ;
filenames1=dircell1(:,1);
file_path1=fullfile(pathname1,filenames1); %��������������ȫ·��
%��ȡPSD��������ļ���
dirs2=dir([pathname2, '\*.txt']);
dircell2=struct2cell(dirs2)' ;
filenames2=dircell2(:,1);
file_path2=fullfile(pathname2,filenames2); %��������������ȫ·��



% ��ȡÿ��NC�������
for i=1:length(filenames1)
    tempmat=load(char(file_path1(i)));
    [R,C]=size(tempmat);
    Coef1(i)=mat2cell(tempmat,R,C);
end
% ��ȡÿ��PSD�������
for i=1:length(filenames2)
    tempmat=load(char(file_path2(i)));
    [R,C]=size(tempmat);
    Coef2(i)=mat2cell(tempmat,R,C);
end

cd(OutputDir);
DependentFiles={};

% ������Э���������ȡЭ�����ļ�
if strcmp(covariates,'yes')   
    tempmat=load(char(file_path_c1));
    Covar(1)=mat2cell(tempmat,size(tempmat,1),size(tempmat,2));
    tempmat=load(char(file_path_c2));
    Covar(2)=mat2cell(tempmat,size(tempmat,1),size(tempmat,2));
end

% ����Pֵ�����
for i=1:length(filenames1)
    DependentFiles(1)=Coef1(i);
    DependentFiles(2)=Coef2(i);
    if strcmp(covariates,'yes')
        [T, P] = gretna_TTest2(DependentFiles,Covar);
    else
        [T, P] = gretna_TTest2(DependentFiles);
    end
    filestr=char(filenames1(i))
    if ~isempty(strfind(filestr,'All_Node')) %����All_Node.txt�ļ���Pֵ��ҪFDRУ��
        [h, crit_p, adj_ci_cvrg, adj_p]=fdr_bh(P,0.05); % fdr_bh(p,q):��adj_p<qΪ����
        P=adj_p;
    end
    result_P(i)=mat2cell(P,size(P,1),size(P,2));
    str_tmp=char(filenames1(i));
    result_tmp=cell2mat(result_P(i));
    save([str_tmp(1:end-4),'_P.txt'], '-ascii', 'result_tmp');
end

