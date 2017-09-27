function [ runavg ] = runaverage(filtered, meansize)
    fsize = size(filtered,1);
    ts = 1:meansize:fsize;
    te = meansize:meansize:fsize;

    runavg = [];
    for i=1:(fsize/meansize)
        ind = [ts(i):te(i)]';
        runavg = cat(1, runavg, repmat(mean(filtered(ind,:),1), meansize, 1));
    end

end