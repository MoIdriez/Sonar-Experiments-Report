function [ data ] = combinedata(loc, m, n, runavg)
    data = zeros(m, n);
    for i = 1:m
        trial = csvread(strcat(loc, int2str(i), '.txt'));
        if runavg > 0
            data(i, :) = runaverage(trial(:,2), runavg)';
        else
            data(i, :) = trial(:,2);
        end        
    end
end

