function saveplots(location, plots, filenames)
    for i = 1:size(plots,2)
        fileLocation = char(strcat(location,filenames(i)));
        print(plots(i), fileLocation, '-dpng');
        close(plots(i));
    end
end

