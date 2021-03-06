clear
clc

rmpath /home/milham/matlab/REST_V1.7
rmpath /home/milham/matlab/REST_V1.7/Template
rmpath /home/milham/matlab/REST_V1.7/man
rmpath /home/milham/matlab/REST_V1.7/mask
rmpath /home/milham/matlab/REST_V1.7/rest_spm5_files

restoredefaultpath

% addpath(genpath('/home/data/HeadMotion_YCG/YAN_Program/spm8'))
% addpath /home/data/HeadMotion_YCG/YAN_Program/DPARSF_V2.3_130615
% addpath /home/data/HeadMotion_YCG/YAN_Program/DPARSF_V2.3_130615/Subfunctions/
% addpath /home/data/HeadMotion_YCG/YAN_Program/REST_V1.8_130615

addpath(genpath('/home/data/Projects/Zhen/commonCode/spm8'))
addpath /home/data/Projects/Zhen/commonCode/DPARSF_V2.3_130615
addpath /home/data/Projects/Zhen/commonCode/DPARSF_V2.3_130615/Subfunctions/
addpath /home/data/Projects/Zhen/commonCode/REST_V1.8_130615

dataDir=['/home/data/Projects/Zhen/BIRD/results/CPAC_zy1_24_14_reorganized/noGSR/FunImgCWAS/'];
%subListFile='/home/data/Projects/Zhen/BIRD/data/final110sub.txt';
subListFile='/home/data/Projects/Zhen/BIRD/data/tmp.txt';
subList1=fopen(subListFile);
subList=textscan(subList1, '%s', 'delimiter', '\n')
subList=cell2mat(subList{1})
numSub=size(subList, 1)

effect='DT_group_name' % can be "DT_group_name" or "age_demeanByDT_group"
MaskData='/home/data/Projects/Zhen/BIRD/mask/CWASMask_noGSR/stdMask_110sub_3mm_noGSR_100prct.nii.gz'
mkdir (['/home/data/Projects/Zhen/BIRD/results/CPAC_zy1_24_14_reorganized/noGSR/CWAS_110sub/', effect, '_followUp'])
outputDir= ['/home/data/Projects/Zhen/BIRD/results/CPAC_zy1_24_14_reorganized/noGSR/CWAS_110sub/', effect, '_followUp/'];
 ROIDef={['/home/data/Projects/Zhen/BIRD/results/CPAC_zy1_24_14_reorganized/noGSR/CWAS_110sub/mdmr3mmFWHM6/cluster_mask_', effect, '.nii']}
 
for i=1:numSub
    sub=subList(i, 1:9);
    AllVolume=[dataDir, 'normFunImg_', sub, '_3mm_fwhm6_masked.nii.gz'];
       
    OutputName=[outputDir, 'FC_', effect, '_', sub];
    IsMultipleLabel=1;
    [FCBrain, Header] = y_SCA(AllVolume, ROIDef, OutputName, MaskData, IsMultipleLabel);
end
