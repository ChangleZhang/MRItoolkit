%Name:Img2txt
%Function:��img�ļ���ȡ��ת��Ϊһ��ɨ���ʽ��txt�ļ�(����unity����)
%Author:Changle Zhang, zhangchanglehit@163.com
clc;clear all;close all;
[hdr,filetype,fileprefix,machine] = load_nii_hdr('E:\SAPHO\DTI\T1\ND-SAPHO\S02\20150725_192944MPRAGE26s013a1001.hdr');
[img,hdr] = load_nii_img(hdr,filetype,fileprefix,machine);
pic=double(img(:,:,60));
imshow(pic,[0 255]);
savemat=zeros(1,216*256);
counter=1;
for i=1:216
    for j=1:256
        savemat(counter)=pic(i,j);
        counter=counter+1;
    end
end
savemat=savemat';
save data2.txt -ascii savemat
% showmat=zeros(216,256);
% cc=1;
% for i=1:216
%     for j=1:256
%         showmat(i,j)=savemat(cc);
%         cc=cc+1;
%     end
% end
% figure
% imshow(showmat,[0 255]);
% imgsize=size(img);

% counter=1;
% length=sum(sum(sum(img>100)));
% xsave=zeros(length,1);
% ysave=zeros(length,1);
% zsave=zeros(length,1);
% savemat=zeros(length,1);
% for i=1:imgsize(1)
%     for j=1:imgsize(2)
%         for k=1:imgsize(3)
%             if img(i,j,k)>100
%                 xsave(counter)=i;
%                 ysave(counter)=j;
%                 zsave(counter)=k;
%                 savemat(counter)=img(i,j,k);
%                 counter=counter+1;
%             end
%         end
%     end
% end
% 
% save T1over100img.txt -ascii savemat
% save T1over100x.txt -ascii xsave
% save T1over100y.txt -ascii ysave
% save T1over100z.txt -ascii zsave