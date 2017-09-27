% locations of folders
datadir = 'D:\Git\Data\Experiments\20161207\Time\';
plotdir = 'D:\Git\Sonar Experiments Report\plots\20161207\Time\Individual\';

% sonars and sample interval
sonars = {'EZ' 'EZ1' 'EZBrown'};
interv = {'10' '50' '100'};

% foreach of the sonars
for i = 1:size(sonars, 2)
    % foreach of the intervals
    for j = 1:size(interv, 2)
        % let's get the file's location
        fileLocation = char(strcat(datadir, sonars(i), '\', interv(j), '.txt'));
        
        % now let's read in the data and split out the scans
        data = splitdata2Cells(csvread(fileLocation), 4);
        
        % get individual plots
        f1 = figure;
        for x = 1:size(data, 2)
            trial = cell2mat(data{x});
            subplot(4,6,x);
            plot(trial);
            title(strcat('Trial no: ', int2str(x)));
        end
        
        % get individual plots with running average
        f2 = figure;
        for x = 1:size(data, 2)
            trial = cell2mat(data{x})';
            run = runaverage(trial, 10);
            subplot(4,6,x);
            plot(run);
            title(strcat('File No.', int2str(x)));
        end
        
        % overlay all forward plots next to all backward plots
        forward = data(:,1:2:end);
        backward = data(:,2:2:end);
        
        f3 = figure('units','normalized','outerposition',[0 0 1 1]);
        subplot(1,2,1);
        hold on;
        for x = 1:size(forward, 2)
            trial = cell2mat(forward{x});
            plot(trial);
        end
        hold off;
        legend(strread(num2str(1:12),'%s'));
        
        subplot(1,2,2);
        hold on;
        for x = 1:size(backward, 2)
            trial = cell2mat(backward{x});
            plot(trial);
        end
        hold off;
        legend(strread(num2str(1:12),'%s'));
                
        % overlay all forward plots next to all backward plots with mean
        forwardArray = equalizeCellArrays(forward);
        forwardmean = mean(forwardArray');
        backwardArray = equalizeCellArrays(backward);
        backwardmean = mean(backwardArray');
        
        
        f4 = figure('units','normalized','outerposition',[0 0 1 1]);
        subplot(1,2,1);
        hold on;
        plot(forwardArray, 'Color', [0 1 0 0.3]);
        plot(forwardmean, 'Color', [0 0 0 1]);
        
        subplot(1,2,2);
        hold on;
        plot(backwardArray, 'Color', [0 1 0 0.3]);
        plot(backwardmean, 'Color', [0 0 0 1]);
        
        f5 = figure('units','normalized','outerposition',[0 0 1 1]);
        
        hold on;
        plot(forwardArray, 'Color', [0 1 0 0.3]);
        plot(forwardmean, 'Color', [1 0 0 1]);
                
        plot(fliplr(backwardArray')', 'Color', [0 1 0 0.3]);
        plot(fliplr(backwardmean), 'Color', [0 0 1 1]);
        
        forwardstd = std(forwardArray');
        backwardstd = std(backwardArray');
        
        f6 = figure('units','normalized','outerposition',[0 0 1 1]);
                
        subplot(1,2,1);
        hold on;
        plot(forwardArray, 'Color', [0 1 0 0.3]);
        plot(forwardmean, 'Color', [0 0 0 1]);
        plot(forwardstd, 'Color', [1 0 0 1]);
        
        
        subplot(1,2,2);
        hold on;
        plot(backwardArray, 'Color', [0 1 0 0.3]);
        plot(backwardmean, 'Color', [0 0 0 1]);
        plot(backwardstd, 'Color', [1 0 0 1]);
                
        
        % save all these plots
        plots = [f1 f2 f3 f4 f5 f6];
        plotnames = {...
            char(strcat(sonars(i), ' - ', interv(j), ' - Raw individual results'))...
            char(strcat(sonars(i), ' - ', interv(j), ' - RunAvg individual results'))...
            char(strcat(sonars(i), ' - ', interv(j), ' - Combine seperate directional results'))...            
            char(strcat(sonars(i), ' - ', interv(j), ' - Combine seperate directional results with mean'))...
            char(strcat(sonars(i), ' - ', interv(j), ' - Combine all directional results with mean'))...
            char(strcat(sonars(i), ' - ', interv(j), ' - Combine seperate directional results with mean and standard deviation'))...
            };
        saveplots(plotdir, plots, plotnames);
        
    end
end