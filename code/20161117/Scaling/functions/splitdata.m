function M = splitdata(data, index)
    M = [];
    temp = [];
    % split up the data
    for i = 1:size(data,1)
        if data(i,1) == -1
            M = [M;temp];
            temp = [];        
        else
            temp = [temp data(i,index)];
        end
    end
    M = M';
end

