% author: Chenfei Ye upgrated by ZCL
% function: ת��Ŀ��·���������ļ����е�.bvec�ļ�ΪDiffusion Toolkit�������ݶ�byce_DT.txt
clc;
clear all;
cd 'E:\biomedical signal\AD_HKU\6Oct2014\AD&MCI';   %���������ļ����ļ���
filename = dir ('.');                               %��ȡ����.��1�� ..��2�� ���ڵ������ļ�������
dircell = struct2cell(filename);                       %�ṹ�仯��cell
name1 = dircell(1,:);                                 %�����ļ���cell��ʽ
len = length(name1);                                  %����Ϊlen

for i = 3:len
    %cc=int2str(i);
    c=name1(i,:);                                       %��ȡstructure��3������ÿ��λ�õ�cell
    cc=char(c);                                         %�����λ�õ�cellת��Ϊstr
    ppath=['E:\biomedical signal\AD_HKU\6Oct2014\NORMAL\' cc '\DWI_B0_1000'];   %·���ַ���
cd (ppath);                                                             %����·��
%%
num_g=33;
%%
filename=dir('*.bvec');
bvec=load(filename.name);

bvec=bvec';

temp=cell(num_g,1);
for i=0:num_g-1
    temp{i+1,1}=strcat(num2str(bvec(i+1,1),4),',',num2str(bvec(i+1,2),4),',',num2str(bvec(i+1,3),4));
end

fid=fopen('bvec_DT.txt','wt');
for i=1:num_g
	fprintf(fid,'%s\n',temp{i,1});
end
status= fclose(fid)
end