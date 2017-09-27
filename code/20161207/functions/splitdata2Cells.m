function M = splitdata2Cells(data, index)
    M = {};
    temp = {};
    % split up the data
    for i = 1:size(data,1)
        if data(i,1) == -1
            M{size(M,2)+1} = temp;
            temp = {};        
        else
            temp{size(temp,2)+1} = data(i,index);
        end
    end
end

