%function: sort the affine result
%author ;changlezhang (zhangchanglehit@163.com)
%update:2016-Dec-10th
clc;clear all;close all;

cd G:/ADNI_affine;
cd affine_result_NC;

dirs=dir;
dircell=struct2cell(dirs)';
filenames=dircell(:,1);
filenames=filenames(3:length(filenames));


%��b0ͼƬ���й鵵
for i=10:16
    folder_name = num2str(i);
    mkdir(folder_name);
    num = 1;%��ʼ������
    for num=1:length(filenames)
        if (strfind(char(filenames(num)),strcat(folder_name,'_b0'))~=0)
            movefile(char(filenames(num)),folder_name);
        end
        
    end
end

for i=1:16
    folder_name = num2str(i);
    mkdir(folder_name);
    num = 1;%��ʼ������
    for num=1:length(filenames)
        if (strfind(char(filenames(num)),strcat(folder_name,'_b0'))~=0)
            movefile(char(filenames(num)),folder_name);
        end
        
    end
end
%��b0�鵵����

%������ͼƬ���й鵵
for i=10:16
    folder_name = num2str(i);
    mkdir(folder_name);
    num = 1;%��ʼ������
    for num=1:length(filenames)
        if (strfind(char(filenames(num)),strcat('00',folder_name))~=0)
            movefile(char(filenames(num)),folder_name);
        end
        
    end
end
%�ڴ˽���·���򵼸���
dirs=dir;
dircell=struct2cell(dirs)';
filenames=dircell(:,1);
filenames=filenames(3:length(filenames));


for i=1:16
    folder_name = num2str(i);
    mkdir(folder_name);
    num = 1;%��ʼ������
    for num=1:length(filenames)
        if (strfind(char(filenames(num)),strcat('00',folder_name))~=0)
            movefile(char(filenames(num)),folder_name);
        end
        
    end
end
%������ͼƬ�鵵����