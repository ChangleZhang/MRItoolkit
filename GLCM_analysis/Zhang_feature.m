clc;clear all;close all;
load D:\ZCL\����-��������\codes\codes\select_feature.mat;
load D:\ZCL\����-��������\codes\codes\selectROI.mat;
load D:\ZCL\����-��������\codes\codes\method.mat;
path = 'D:\ZCL\����-��������\graymatrixdata\graymatrixdata\original_excel_data\NC';
cd(path);
method(4)={'Trace'};
savemat = zeros(17,231);
savemat(2:17,1)=1:16;
num = 1;
for i = 1:4
    cd(char(method(i)));                  %�����i������
    for j = 1:23                    %23������
        for k =1:10
           %savemat(1,k*j+1)=char(select_feature(k));
           savemat(2:17,num+1)=xlsread (char(strcat(roi(j),'.xlsx')),char(strcat(select_feature(k))),'A21:A36');
           num=num+1;
        end
    end
    save savemat
    cd (path);                      %����Ŀ¼
end