function [] = local_label_propagation(datasetName,number,radius,sigma)  

    [img,gt] = get_data(datasetName);
    img = img./max(img(:));
    class_num = length(unique(gt));
    [m,n,c] = size(img);  

    result_name = 'gause_label_svm.txt';
    fid = fopen(result_name,'a+');

    width = 2*radius+1;  
    S = zeros(width,width);%pix Similarity  
    D = fspecial('gaussian',[2*radius+1,2*radius+1],sigma); 

    col_rol_index = reshape([1:(m+2*radius)*(n+2*radius)],m+2*radius,n+2*radius);
    dex = [1,11,26,33,52,58,85,104,111,121];
    B = cell(2,class_num-1);
    link_graph = reshape(1:m*n,m,n);
    pad_graph = padarray(link_graph,[radius radius],0);
    for s = 1:size(number,2)
        nTrEachClass = number(s);
        for index=1:10
            tic;
            pad_img = padarray(img,[radius,radius],'replicate');
            pad_zero = padarray(ones(m,n),[radius,radius],0);
            [~, ~, ~, ~,index_train, index_test, ~, ~, ~, ~ ] = ChooseSample(img,gt,nTrEachClass, dex(index));

            temp_i = zeros(m*n,1);
            temp_j = zeros(m*n,1);
            temp_v = zeros(m*n,1);
            
            label = zeros(m*n,class_num);
            for ll = 1:length(index_train)
                label(index_train(ll),gt(index_train(ll))+1) = 1;
            end
 
            ind = 1;

            [row, col] = ind2sub([m,n], setdiff([1:m*n],index_train));
            for i=1:size(row,2)
                row_i = row(i);
                col_j = col(i);
                S = exp(-2*sum(abs(pad_img(row_i:row_i+2*radius,col_j:col_j+2*radius,:)-pad_img(row_i+radius,col_j+radius,:))./(abs(pad_img(row_i:row_i+2*radius,col_j:col_j+2*radius,:)-pad_img(row_i+radius,col_j+radius,:))+abs(pad_img(row_i:row_i+2*radius,col_j:col_j+2*radius,:)+pad_img(row_i+radius,col_j+radius,:))+eps),3));
                % S = exp(-sqrt(sum(pad_img(row_i:row_i+2*radius,col_j:col_j+2*radius,:)-pad_img(row_i+radius,col_j+radius,:).^2./(0.22).^2,3)));
                S(int32(end/2),int32(end/2)) = 0;
                S = S.*D;   
                S = S(pad_zero(row_i:row_i+2*radius,col_j:col_j+2*radius)>0);
                S = S./sum(S(:));
                len = size(S,1);
                
                mat_ind = pad_graph(row_i:row_i+2*radius,col_j:col_j+2*radius);
                mat_ind = mat_ind(mat_ind>0);
                temp_i(ind:ind+len-1) = link_graph(row_i,col_j);
                temp_j(ind:ind+len-1) = mat_ind;
                temp_v(ind:ind+len-1) = S(:);
                ind = ind + len;
            end  

            for i = 1:size(index_train)
                temp_i(ind) = index_train(i);
                temp_j(ind) = index_train(i);
                temp_v(ind) = 1;
                ind = ind + 1;
            end
            W = sparse(temp_i(1:ind-1),temp_j(1:ind-1),temp_v(1:ind-1),m*n,m*n);
            old_predict = zeros(m,n);
            iter = 0;

            while true
                iter = iter + 1
                label = W*label;  
                [~,P] = max(label,[],2);
                predict = P-1;

                if(min(predict(:)) > 0)
                    [acc,~,~,~] = confusion(gt(index_test),predict(index_test))
                    sum(sum(predict ~= old_predict))
                    diff_p = sum(sum(predict ~= old_predict))*1.0/(m*n);
                    if diff_p < 0.0001 || iter ==300
                        break;
                    end
                end

                old_predict = predict;
            end  
            [~,P] = max(label,[],2);
            predict = P-1;
            predict = reshape(predict,m,n);
            toc
            disp(['运行时间: ',num2str(toc)]);
            [oa(index),aa(index),kappa(index),ua,~]=confusion(gt(index_test),predict(index_test))
        end
        oa_mean = roundn(mean(oa),-4)
        oa_std = roundn(std(oa),-4)
        aa_mean = roundn(mean(aa),-4);
        aa_std = roundn(std(aa),-4);
        kappa_mean = roundn(mean(kappa),-4);
        kappa_std = roundn(std(kappa),-4);
        fprintf(fid,'%s %d  %d  %d   %g ± %g___%g ± %g___%g ± %g\n', datasetName,number(s),radius,sigma,oa_mean*100,oa_std*100,aa_mean*100,aa_std*100,kappa_mean*100,kappa_std*100);
    end  
    fclose(fid);
    
end
