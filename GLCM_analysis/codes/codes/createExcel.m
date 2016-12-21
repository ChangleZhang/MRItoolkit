%����excel
for e_num = 1:28;
    load('I:\Data\codes\roi_name');   
    load('I:\Data\codes\ans_set');       %���ػҶȹ������������������
    filespath_excel='I:\Data\NC';
    filenames_excel=dir(filespath_excel);
    filenames_excel=struct2cell(filenames_excel);
    filenames_excel=filenames_excel(1,3:20)';
    
    roi_load=char(roi_name(e_num));          %��ǰROI������
    destination=cell(28,1);
    destination2=cell(28,1);
    destination3=cell(28,1);
    destination4=cell(28,1);
    
    destination{e_num,1}=strcat('I:\Data\graymatrixdata\analysis\NC\B0\',roi_load,'.xlsx');
    destination2{e_num,1}=strcat('I:\Data\graymatrixdata\analysis\NC\Trace\',roi_load,'.xlsx');
    destination3{e_num,1}=strcat('I:\Data\graymatrixdata\analysis\NC\MD\',roi_load,'.xlsx');
    destination4{e_num,1}=strcat('I:\Data\graymatrixdata\analysis\NC\FA\',roi_load,'.xlsx');
    
    for sheet_num = 1:22;
        sheetname = cell2mat(ans_set(sheet_num));
        xlswrite(destination{e_num,1},filenames_excel,sheetname,'A2');
        xlswrite(destination2{e_num,1},filenames_excel,sheetname,'A2');
        xlswrite(destination3{e_num,1},filenames_excel,sheetname,'A2');
        xlswrite(destination4{e_num,1},filenames_excel,sheetname,'A2');  
    end
end