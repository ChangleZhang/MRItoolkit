%function:ͳ��һ��Ŀ¼�����зָ�����283��������ROI��С���ŵ�һ��txt�ĵ���
clc;clear all;close all;
pathname_G1 = 'G:\��������ҽԺ\����ҽ������\INFARCT�ָ���\�ļ���';
%pathname_G1 = 'G:\��������ҽԺ\����ҽ������\ich_�ָ���\�ϼ�';
cd(pathname_G1);
dirs_G1=dir([pathname_G1, '\*.*']);
dircell_G1=struct2cell(dirs_G1)' ;
filenames_G1=dircell_G1(3:length(dircell_G1)-1,1);
%file_path_G1=fullfile(pathname_G1,filenames_G1); %��������������ȫ·��
dirs_G2=dir([pathname_G1, '\*.*']);
dircell_G2=struct2cell(dirs_G2)' ;
filenames_G2=dircell_G2(3:length(dircell_G2)-1,1);
savemat = zeros(length(filenames_G1),283);
 for i=1:length(filenames_G1)
    cd(char(filenames_G1(i)));
    %cd(char(filenames_G1(i)));
    cd output;
    clear dirs_G2;clear dircell_G2;clear filenames_G2;
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
            for k = 1:283
               counter = length(find(img==k));
               savemat(i,k)= counter;
            end
        end
        
    end
   
    
    cd(pathname_G1);
 end
 %ת���ɰٷֱ���ʽ-ȥ��xxx����
 savemat1 = zeros(length(filenames_G1),283);
 for m = 1:length(filenames_G1);
    whole = sum(savemat(m,:))-savemat(m,163)-savemat(m,164)-savemat(m,248)-savemat(m,249)-savemat(m,250)-savemat(m,251)-savemat(m,254);
    for n = 1:283
        if n==163 || n==164 || n==248 ||n==249 ||n==250 ||n==251 ||n==254
            savemat1(m,n)=0;
        else
            savemat1(m,n) = savemat(m,n)/whole; 
        end
    end
 end
 save wholeBrain_voxel.txt -ascii savemat;
 save wholeBrain_voxel_percent.txt -ascii savemat1;
