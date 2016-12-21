%����Ҷȹ�������
for i=1:16;                                                         %����
% i=13;
         for j=1:28;    %roi��Ŀ                                          
         %j=10;
            clc;
            clearvars -except i j;

            addpath('G:\����-��������\codes\codes\functions');            %����function�Ĺ���·�� 
            numstruct=load('G:\����-��������\codes\codes\num.mat');       %ROI��Ӧ������
            load('G:\����-��������\codes\codes\roi_name');                %ROI������
            filespath='G:\ADNI_affine\affine_result_AD';                 %�ļ���·��
            filenames=dir(filespath);
            filenames=struct2cell(filenames);
            filenames=filenames(1,3:18)';
            num = numstruct.num1;
%           roi_name = roi_namestruct.raw1;
         
            roi_cur = char(roi_name(j));                        %��ǰROI������
            roi_num = num(j,:)                                  %��ǰROI����Ӧ������
            roi_num(find(roi_num==0))=287;
           
            file_cur=char(filenames(i,1));                      %��i���ļ�
            display(file_cur);
            s01=strcat(file_cur(1:length(file_cur)));
            s1=strcat('G:\ADNI_affine\affine_result_AD\',file_cur);
            path0=strcat('G:\�ָ���_ADNI\ADT1SEG\AD',s01,'\output\');
                cd(path0);          %��ȥ�ҷָ���
                dirs=dir;
                dircell=struct2cell(dirs)';
                niifilenames=dircell(:,1);
                niifilenames=niifilenames(3:length(niifilenames));
                    for num1=1:length(niifilenames)
                            if (strfind(char(niifilenames(num1)),'286Labels_MNI.hdr') ~=0 )     %Ѱ��286�ָ����е�ͷ�ļ�
                                path0 = strcat(path0,char(niifilenames(num1)));
                            end
                    end
    
            path1=strcat(s1,'\affine_000',file_cur,'_MD.nii');
            path2=strcat(s1,'\affine_',file_cur,'_b0.nii');
            path3=strcat(s1,'\affine_000',file_cur,'_FA.nii');
            path4=strcat(s1,'\affine_000',file_cur,'_L23m.nii');


            source=strcat('G:\Data\',roi_cur);
            destination=strcat('G:\Data\graymatrixdata\AD\',s01,'\',roi_cur);


            [hdr,filetype,fileprefix,machine] = load_nii_hdr(path0);
            [seg,hdr] = load_nii_img(hdr,filetype,fileprefix,machine);
            [hdr,filetype,fileprefix,machine] = load_nii_hdr(path1);
            [MD,hdr] = load_nii_img(hdr,filetype,fileprefix,machine);
            [hdr,filetype,fileprefix,machine] = load_nii_hdr(path2);
            [B0,hdr] = load_nii_img(hdr,filetype,fileprefix,machine);
            [hdr,filetype,fileprefix,machine] = load_nii_hdr(path3);
            [FA,hdr] = load_nii_img(hdr,filetype,fileprefix,machine);
            [hdr,filetype,fileprefix,machine] = load_nii_hdr(path4);
            [TRACE,hdr] = load_nii_img(hdr,filetype,fileprefix,machine);
            seg=double(seg);
            MD=double(MD);
            B0=double(B0);
            TRACE=double(TRACE);
            FA=double(FA);
            [a,b,c]=size(seg);

            %�ҵ�ָ����ROI����
            loc=find(seg==roi_num(1)|seg==roi_num(2)|seg==roi_num(3)|seg==roi_num(4)|seg==roi_num(5)|seg==roi_num(6)|seg==roi_num(7)|seg==roi_num(8)|seg==roi_num(9)|seg==roi_num(10)|seg==roi_num(11)|seg==roi_num(12)|seg==roi_num(13));


            mkdir(source);%������Ŀ¼
            cd(source);%������Ŀ¼·��

            volume=numel(loc);      %ȷ��ROI�����������
            save volume volume;
            mask=zeros(a,b,c);
            mask(loc)=1;


            M_target1=mask.*B0;
            B0_data=nonzeros(M_target1);        %����Ĥ���Ӻ�Ѳ�Ϊ���λ����ȡ����
            save B0_data B0_data;

            M_target3=mask.*TRACE;
            TRACE_data=nonzeros(M_target3);
            save TRACE_data TRACE_data;

            M_target4=mask.*MD;
            MD_data=nonzeros(M_target4);
            save MD_data MD_data;
             
            M_target2=mask.*FA;
            FA_data=nonzeros(M_target2);
            save FA_data FA_data;
            
            GLCM_B0=zeros(64,64,217*4);
            temp = M_target1; 
            temp(find(temp == 0)) = NaN;
            minvalue = min(min(min(temp)));
            maxvalue = max(max(max(M_target1)));
            for m = 1:b;
                Mtemp = M_target1(:,m,:);
                Mcomatrix = reshape(Mtemp,a,c);
                [GLCM,SI] = graycomatrix(Mcomatrix,'Graylimits',[minvalue maxvalue],'NumLevels',64,'Offset',[0 1; -1 1; -1 0; -1 -1]);
                GLCM_B0(:,:,4*m-3:4*m)=GLCM();
            end
            stats_B0 = GLCM_Features4(GLCM_B0,0);
            save stats_B0 stats_B0; 
            
            GLCM_Trace=zeros(64,64,217*4);
            temp = M_target3; 
            temp(find(temp == 0)) = NaN;
            minvalue = min(min(min(temp)));
            maxvalue = max(max(max(M_target3)));
            for m = 1:b;
                Mtemp = M_target3(:,m,:);
                Mcomatrix = reshape(Mtemp,a,c);
                [GLCM,SI] = graycomatrix(Mcomatrix,'Graylimits',[minvalue maxvalue],'NumLevels',64,'Offset',[0 1; -1 1; -1 0; -1 -1]);
                GLCM_Trace(:,:,4*m-3:4*m)=GLCM();
            end
            stats_Trace = GLCM_Features4(GLCM_Trace,0);
            save stats_Trace stats_Trace;
            
            GLCM_MD=zeros(64,64,217*4);
            temp = M_target4; 
            temp(find(temp == 0)) = NaN;
            minvalue = min(min(min(temp)));
            maxvalue = max(max(max(M_target4)));
            for m = 1:b;
                Mtemp = M_target4(:,m,:);
                Mcomatrix = reshape(Mtemp,a,c);
                [GLCM,SI] = graycomatrix(Mcomatrix,'Graylimits',[minvalue maxvalue],'NumLevels',64,'Offset',[0 1; -1 1; -1 0; -1 -1]);
                GLCM_MD(:,:,4*m-3:4*m)=GLCM();
            end
            stats_MD = GLCM_Features4(GLCM_MD,0);
            save stats_MD stats_MD;
            
            GLCM_FA=zeros(64,64,217*4);
            temp = M_target2; 
            temp(find(temp == 0)) = NaN;
            minvalue = min(min(min(temp)));
            maxvalue = max(max(max(M_target2)));
            for m = 1:b;
                Mtemp = M_target2(:,m,:);
                Mcomatrix = reshape(Mtemp,a,c);
                [GLCM,SI] = graycomatrix(Mcomatrix,'Graylimits',[minvalue maxvalue],'NumLevels',64,'Offset',[0 1; -1 1; -1 0; -1 -1]);
                GLCM_FA(:,:,4*m-3:4*m)=GLCM();
            end
            stats_FA = GLCM_Features4(GLCM_FA,0);
            save stats_FA stats_FA;
            
            
            movefile(source,destination);
    
         end
end
