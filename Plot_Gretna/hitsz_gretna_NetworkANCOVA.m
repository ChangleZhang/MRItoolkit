%% hitsz_gretna_NetworkANCOVA_w.m
% ���������ͳ�Ʒ��� ANCOVA with covariates and FDR correction
% w means weighted network
% ��Ҫ�õ��ĳ��������gretna_ANCOVA1.m fdr_bh.m
% Input: 
% covariates��<string> yes�������Э����,no��������Э����
% pathname1:<string> ��1�������в����ļ�txt���ļ���·��; 
% pathname2:<string> ��2�������в����ļ�txt���ļ���·��; 
% pathname3:<string> ��3�������в����ļ�txt���ļ���·��; 
% file_path_c1:<string> ��1Э�����ļ�txt·��; 
% file_path_c2:<string> ��2Э�����ļ�txt·��;
% file_path_c3:<string> ��3Э�����ļ�txt·��;
% OutputDir:<string> Pֵ���·��
% 
% Output:�����·��������txt��Pֵ�ļ�
%%
clc
clear
covariates='yes'; %yes�������Э������no��������Э����

%ѡ��NetworkĿ¼

pathname1='C:\Users\Figo-workstation\Desktop\XH\D\ANA_RESULT_sparsity\Network_Analysis\';%��1�������в����ļ�txt���ļ���·��
pathname2='C:\Users\Figo-workstation\Desktop\XH\NC\ANA_RESULT_sparsity\Network_Analysis\';%��2�������в����ļ�txt���ļ���·��
pathname3='C:\Users\Figo-workstation\Desktop\XH\ND\ANA_RESULT_sparsity\Network_Analysis\';%��3�������в����ļ�txt���ļ���·��

file_path_c1='D:\SAPHO_processed\Cov_D.txt';%��1Э�����ļ�txt·��
file_path_c2='D:\SAPHO_processed\Cov_NC.txt';%��2Э�����ļ�txt·��
file_path_c3='D:\SAPHO_processed\Cov_ND.txt';%��3Э�����ļ�txt·��

OutputDir='E:\ML\matlab\GRETNA_1.2.1_release'; %Pֵ���·��
%��ȡ��1�µ��������������
dirs1=dir([pathname1, '*.txt']);
dircell1=struct2cell(dirs1)' ;
filenames1=dircell1(:,1);
file_path1=fullfile(pathname1,filenames1); %����������ļ���ȫ·��
%��ȡ��2�µ��������������
dirs2=dir([pathname2, '*.txt']);
dircell2=struct2cell(dirs2)' ;
filenames2=dircell2(:,1);
file_path2=fullfile(pathname2,filenames2); %����������ļ���ȫ·��
%��ȡ��3�µ��������������
dirs3=dir([pathname3, '*.txt']);
dircell3=struct2cell(dirs3)' ;
filenames3=dircell3(:,1);
file_path3=fullfile(pathname3,filenames3); %����������ļ���ȫ·��

% ��ȡ��1ÿ���������
for i=1:length(filenames1)
    tempmat=load(char(file_path1(i)));
    [R,C]=size(tempmat);
    Coef1(i)=mat2cell(tempmat,R,C);
end
% ��ȡ��2ÿ���������
for i=1:length(filenames2)
    tempmat=load(char(file_path2(i)));
    [R,C]=size(tempmat);
    Coef2(i)=mat2cell(tempmat,R,C);
end
% ��ȡ��3ÿ���������
for i=1:length(filenames3)
    tempmat=load(char(file_path3(i)));
    [R,C]=size(tempmat);
    Coef3(i)=mat2cell(tempmat,R,C);
end

cd(OutputDir);
DependentFiles={};
% ������Э���������ȡЭ�����ļ�
if strcmp(covariates,'yes')   
    tempmat=load(char(file_path_c1));
    Covar(1)=mat2cell(tempmat,size(tempmat,1),size(tempmat,2));
    tempmat=load(char(file_path_c2));
    Covar(2)=mat2cell(tempmat,size(tempmat,1),size(tempmat,2));
    tempmat=load(char(file_path_c3));
    Covar(3)=mat2cell(tempmat,size(tempmat,1),size(tempmat,2));
end
% ����Pֵ�����
for i=1:length(filenames1)
    DependentFiles(1)=Coef1(i);
    DependentFiles(2)=Coef2(i);
    DependentFiles(3)=Coef3(i);
    if strcmp(covariates,'yes')
        [F, P] = gretna_ANCOVA1(DependentFiles,Covar);
    else
        [F, P] = gretna_ANCOVA1(DependentFiles);
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

