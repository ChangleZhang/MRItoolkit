clc;
clear;
s1='C:\Users\Figo-workstation\Desktop\AmS\AD\800010_060328_air\img\DWI\DWI.hdr';


[hdr,filetype,fileprefix,machine] = load_nii_hdr(s1);
[img,hdr] = load_nii_img(hdr,filetype,fileprefix,machine);


for i = 1:34
   abc=img(:,:,1+(i-1)*60:60+(i-1)*60);
   temp=make_ana(abc);
   string= num2str(i);
   
   save_untouch_nii(temp, strcat('DWI_',num2str(i))); 
    
end
