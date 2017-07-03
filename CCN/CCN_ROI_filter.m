% Author:Challen
% 2017-6-30
%funtion: set CCN in 00001_FA_normalize_to_CCN_withothers ROI to 1,and
%remove other ROIs
clc
clear all;
close all;  %initialization
%cd 'F:\ADNI_AD\ADT1SEG\AD16\output'
% name='Zhuxiaolan';
[filename,pathname]=uigetfile({'*.*'},'choose any dcm file');
cd(pathname);
[hdr,filetype,fileprefix,machine] = load_nii_hdr(filename);
[img,hdr] = load_nii_img(hdr,filetype,fileprefix,machine);

%CCN:
temp1=[1:4,15,16,21,22]; %label number
index=(img==temp1(1)); %index��ͼ���ж�Ӧlabel number���������
for t=temp1
    index1=(img==t);
    index=index|index1;
end
img(index)=1;

%other than CCN:
temp1=[5:14,17:20,23:59]; %label number
index=(img==temp1(1)); %index��ͼ���ж�Ӧlabel number���������
for t=temp1
    index1=(img==t);
    index=index|index1;
end
img(index)=0;

%tabulate(img(:))


%��1��Lable���ֵ����
Lables=unique(img);
for i=1:length(Lables)
    temp=Lables(i); %label number
    index=(img==temp); %index��ͼ���ж�Ӧlabel number���������
    img(index)=i-1;
end

CC_286_L=make_ana(img);     %savemat

%cd(['H:\DTI_file\',name,'\fiber']) %���и���·��
save_untouch_nii(CC_286_L,'CCN_ROI');%save_untouch_nii(CC_286_R,'CC_286_R');
tabulate(img(:))
