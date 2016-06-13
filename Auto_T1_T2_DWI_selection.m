% 2015/3/22
% author: Chenfei YE upgraded by ZCL
% m�ļ����ܣ���ԭʼdicom�ļ�����ȡT1,T2,DWIͼ��

clc
clear;

% ���س������������ʾ����
load train
% ��Ҫ�Զ�������ļ�·����ѡȡ�����ļ�
[filename,pathname]=uigetfile({'*.dcm'},'choose any dcm file');
cd(pathname);   
dirs=dir([pathname, '*.dcm']);
dircell=struct2cell(dirs)' ;
filenames=dircell(:,1);
mkdir('T1');
% ������ȡdicom�ļ��Ĳ�������
for n=1:numel(filenames);
    dcminfo=dicominfo(char(filenames(n)));
    if (strcmp(dcminfo.ProtocolName,'t1_fl2d_tra')==true)&&(strcmp(dcminfo.ProtocolName,'t1_fl2d_tra_p2')==true)
        
        copyfile(char(filenames(n)),'T1');  
    end
    
end

%T2
dirs=dir([pathname, '*.dcm']);  
dircell=struct2cell(dirs)' ;
filenames=dircell(:,1);
mkdir('T2');
% ������ȡdicom�ļ��Ĳ�������
for n=1:numel(filenames);
    dcminfo=dicominfo(char(filenames(n)));
    if (strcmp(dcminfo.ProtocolName,'t2_tse_tra_p2')==true)&&(strcmp(dcminfo.ImageType,'ORIGINAL\PRIMARY\M\ND\NORM\FM\FIL')==true)
    %if strcmp(dcminfo.ImageType,'DERIVED\PRIMARY\DIFFUSION\FA\ND\NORM')==true
        copyfile(char(filenames(n)),'T2');
    end
    
end

%DWI
dirs=dir([pathname, '*.dcm']);
dircell=struct2cell(dirs)' ;
filenames=dircell(:,1);
mkdir('DWI');
% ������ȡdicom�ļ��Ĳ�������
for n=1:numel(filenames);
    dcminfo=dicominfo(char(filenames(n)));
    if (strcmp(dcminfo.ProtocolName,'ep2d_diff_mddw_20_p2')==true)&&(strcmp(dcminfo.ImageType,'ORIGINAL\PRIMARY\M\ND\MOSAIC')==true)
    %if strcmp(dcminfo.ImageType,'DERIVED\PRIMARY\DIFFUSION\FA\ND\NORM')==true
        copyfile(char(filenames(n)),'DWI');
    end
    
end



% ���н�����ʾ��

sound(y,Fs);