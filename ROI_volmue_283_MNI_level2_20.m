%function:ͳ��һ��Ŀ¼�����зָ�����283��������ROI��С���ŵ�һ��txt�ĵ���
clc;clear all;close all;
clc;
clear all;
close all;

load('M2lookuptable.mat'); %para named 'a'

b = a(:,5);
hashset = unique(b);

res = a;
row_num = zeros(21,1);
cnt = 1;
for z =1:283
%     flag = 0;
    dim = size(hashset);
    if(dim(2)~=0)
        for j = 1:dim(1)
            if isequal(res(z,5),hashset(j))
%                 flag = 1;
                row_num(cnt)=z;
                hashset(j)=[];
                cnt=cnt+1;
                break;
            end
        end
    end
%     if(flag==0)
%         res(i,:)=[];
%     end
end
%after that we got important row num in array row_num

cnt = 21;
for z=283:-1:1
    if(z~=row_num(cnt))
        res(z,:)=[];
    else
        cnt=cnt-1;
    end
end
%��ʼ���л���
path = 'G:\����ҽԺ����\��謿���������\NC\NC_M2_level2_type1';
cd(path)
dirs_G1=dir([path, '\*.*']);
dircell_G1=struct2cell(dirs_G1)' ;
filenames_G1=dircell_G1(3:length(dircell_G1),1);
for m=1:length(filenames_G1)
    floder_name = char(filenames_G1(m));
    cd(floder_name);
    disp(floder_name);
    cd('output');
    dirs_G2=dir;
    dircell_G2=struct2cell(dirs_G2)' ;
    filenames_G2=dircell_G2(3:length(dircell_G2),1);
    len = length(filenames_G2);
    for j = 1:len
        
        filenamesIS = char(filenames_G2(j));
        jamar = strfind(filenamesIS,'283Labels_M2_MNI.img');
        if length(jamar) ~= 0
            
            [hdr,filetype,fileprefix,machine] = load_nii_hdr(filenamesIS);
            [img,hdr] = load_nii_img(hdr,filetype,fileprefix,machine);
            %��ʼ���ݲ���
            for indexer=1:21
                for img_index = 1:283
                    if isequal(res(indexer,5),a(img_index,5))
                         if indexer~= 17
                            index=(img==img_index); %index��ͼ���ж�Ӧlabel number���������
                            for t=img_index
                                index1=(img==t);
                                index=index|index1;
                            end
                            img(index)=indexer;
                         else
                             index=(img==img_index); %index��ͼ���ж�Ӧlabel number���������
                            for t=img_index
                                index1=(img==t);
                                index=index|index1;
                            end
                            img(index)=0;
                         end
                    end
                end
            end
            %��1��20���У���Ϊ�ܹ���20������
            Lables=unique(img);
            for z=1:20
                temp=Lables(z); %label number
                index=(img==temp); %index��ͼ���ж�Ӧlabel number���������
                img(index)=z-1;
            end
            
            CC_286_L=make_ana(img);     %savemat
            savename = strcat(floder_name,'_M2_MNI_level2_type1');
            save_untouch_nii(CC_286_L,savename);
            cd(path);    
        end
    end
end
