function [img, gt] = get_data(DataSetName)
    % �Ľ������Ӧ�����İ��box�˲���
    switch DataSetName
        case 'Indianpines'
            load('./dataset/Indian_pines_corrected.mat');
            load('./dataset/Indian_pines_gt.mat');
             img = indian_pines_corrected;gt = double(indian_pines_gt);
        case 'KSC'      
            load('./dataset/KSC.mat');
            load('./dataset/KSC_gt.mat');
            img = KSC; gt = double(KSC_gt);
        case 'Salinas'    
            load('./dataset/Salinas_corrected.mat');
            load('./dataset/Salinas_gt.mat');
            img = salinas_corrected; gt = double(salinas_gt);
        case 'SalinasA' 
            load('./dataset/SalinasA_corrected.mat');load('./dataset/SalinasA_gt.mat');
            img = salinasA_corrected; gt = double(salinasA_gt);
        case 'Pavia' 
         load('./dataset/Pavia.mat');load('./dataset/Pavia_gt.mat');
            img = pavia; gt = double(pavia_gt);
        case 'PaviaU' 
            load('./dataset/PaviaU.mat');
            load('./dataset/PaviaU_gt.mat');
            img = paviaU; gt = double(paviaU_gt);
        case 'Houston' 
            load('./dataset/Houston2013.mat');load('./dataset/Houston2013_gt.mat');
            img = double(CASI); gt = double(gnd_flag);
        case 'Houston2018' 
            load('./dataset/HOU2018_correct.mat');load('./dataset/HOU2018_GT.mat');
            img = img; gt = double(GT);
        case 'Botswana'
            load('./dataset/Botswana.mat');load('./dataset/Botswana_gt.mat');
            img = Botswana; gt = double(Botswana_gt);
        case 'Urban4'
            load('./dataset/Urban_R162.mat');load('./dataset/end4_groundTruth.mat');
            Urban = reshape(Y', 307,307,162); [uMax, Urban_gt] =max(A); Urban_gt = reshape(Urban_gt, 307,307);
            Urban_gt(307, 307) = 0;             %to be compatible  with  nClass = size(ind,1)-1; 
            img = Urban; gt = double(Urban_gt);
        case 'Urban5'
            load('./dataset/Urban_R162.mat');load('../dataset/end5_groundTruth.mat');
            Urban = reshape(Y', 307,307,162); [uMax, Urban_gt] =max(A); Urban_gt = reshape(Urban_gt, 307,307);
            Urban_gt(307, 307) = 0;             %to be compatible  with  nClass = size(ind,1)-1; 
            img = Urban; gt = double(Urban_gt);
        case 'Urban6'
            load('./dataset/Urban_R162.mat');load('./dataset/end6_groundTruth.mat');
            Urban = reshape(Y', 307,307,162); [uMax, Urban_gt] =max(A); Urban_gt = reshape(Urban_gt, 307,307);
            Urban_gt(307, 307) = 0;             %to be compatible  with  nClass = size(ind,1)-1; 
            img = Urban; gt = double(Urban_gt);
        case 'Indianpines5' 
            load('./dataset/Indian_pines_5class.mat');
    %        img = indian_pines_corrected; gt = double(indian_pines_gt);
        case 'Earthquake'
            addpath('E:/History Matching/EarthquakeData');
            load('well_corrected.mat','well_corrected');load('well_gt.mat','well_gt');
            img = well_corrected;y = well_gt;
            clear well_corrected well_gt;        
        case 'LongKou'
            load('./dataset/WHU-Hi-LongKou/WHU_Hi_LongKou.mat');load('./dataset/WHU-Hi-LongKou/WHU_Hi_LongKou_gt.mat');
            img = double(WHU_Hi_LongKou); gt = double(WHU_Hi_LongKou_gt); 
        case 'XuZhou'
            load('D:/Workspace/MATLAB/SW_filter/dataset/XuZhou.mat');
            img = double(reshape(all_x,500,260,436)); gt = double(reshape(all_y,500,260)); 
        case 'HongHu'
            load('./dataset/WHU_Hi_HongHu.mat');
            load('./dataset/WHU_Hi_HongHu_gt.mat');
            img = WHU_Hi_HongHu;gt = double(WHU_Hi_HongHu_gt);
            res = 3.7;
            color_map=[140 67 46;0 0 255;255 100 0;0 255 123;56 94 15;138 54 15;255 240 230;255 192 203;0 199 140;164 75 155;101 174 255;118 254 172;255 153 18; 60 91 112;255,255,0;255 255 125;255 0 255;100 0 255;0 172 254;0 255 0;171 175 80;101 193 60];
        otherwise
            error('Unknown data set requested.');
    end
end