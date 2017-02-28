function saveplots(location, plots, filenames)
    for i = 1:size(plots,2)
        fileLocation = char(strcat(location,filenames(i)));
        disp(fileLocation);
        print(plots(i), fileLocation, '-dpng');
    end
end

