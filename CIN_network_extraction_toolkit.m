%Name:CIN_network_extraction_toolkit
%Function:Extraction CIN(lable 31:36 in AAL 90 atlas set)to show the
%construction
%Author :Changle Zhang e-mail:zhangchanglehit@163.com
clc;clear all;close all;
path='E:\PKU_PSD\JMRI\output_NC\Network';
cd (path);            %进入存储目录，后期可以根据需要修改0000i以及确定不确定等

dirs=dir;
dircell=struct2cell(dirs)';
filenames=dircell(3:14,1);
%FA=load ('00001_dti_FACT_35_02_1_0_Matrix_FA_AAL_Contract_90_2MM_90.txt'); %打开FA
%FA=load ('00001_dti_FACT_35_02_1_0_Matrix_FN_AAL_Contract_90_2MM_90.txt');
%%打开FN
for num=1:12
    FA=load(char(filenames(num)));
    %%打开Length
    %Upper_Left
    for i=1:30
        for j=1:30
            FA(i,j)=0;
        end
    end
    %Upper_Right
    for i = 1:30
        for j = 37:90
            FA(i,j)=0;
        end
    end
    %Lower_Left
    for i=37:90
        for j=1:30
            FA(i,j)=0;
        end
    end
    %Lower_Right
    for i=37:90
        for j=37:90
            FA(i,j)=0;
        end
    end
    
    save('FA_AAL.txt','FA','-ascii');                       %进行保存
    
end