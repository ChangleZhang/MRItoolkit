%��excel��������ROI��Ӧ�����λ��
clc;clear;
source1=strcat('I:\Data\test.xlsx');
readxlRange = 'A1:M28';
[num1,txt1,raw1] = xlsread(source1,readxlRange);
num = num1;
save num num1

% ��excel��������ROI������
% clc;clear;
% source1=strcat('I:\Data\test.xlsx');
% readxlRange = 'N1:N28';
% [num1,txt1,raw1] = xlsread(source1,readxlRange);
% roi_name = raw1;
% save roi_name roi_name

%��excel�ж�ȡҪд��Ans_��ͷ��excel��λ��
% clc;clear;
% source1=strcat('I:\Data\test.xlsx');
% readxlRange = 'B32:W32';
% [num1,txt1,raw1] = xlsread(source1,readxlRange);
% write_co = txt1;
% save write_co write_co;

%��excel�ж�ȡҪд��Bi_��ͷ��excel��λ��18��AD18��NC
% clc;clear;
% source1=strcat('I:\Data\test.xlsx');
% readxlRange = 'X1:X36';
% [num,txt,raw] = xlsread(source1,readxlRange);
% save txt txt;