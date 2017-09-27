function [ ar ] = equalizeCellArrays(cellArray)
    mn = min(size(cell2mat(cellArray{1}), 2));
    for x = 2:size(cellArray, 2)
        tmn = min(size(cell2mat(cellArray{x}), 2));
        if tmn < mn
            mn = tmn;
        end
    end
    
    ar = zeros(mn, size(cellArray, 2));
    for x = 1:size(cellArray, 2)
        tar = cell2mat(cellArray{x});
        ar(:,x) = tar(:, 1:mn);
    end


end

