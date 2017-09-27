% locations of folders
datadir = 'D:\Git\Data\Experiments\20161207\Angle\';
plotdir = 'D:\Git\Sonar Experiments Report\plots\20161207\Angle\Individual\';

% sonars and sample interval
sonars = {'EZ' 'EZ1' 'EZBrown'};
interv = {'10' '25' '50'};

% foreach of the sonars
for i = 1:size(sonars, 2)
    % foreach of the intervals
    for j = 1:size(interv, 2)
        % let's get the file's location
        fileLocation = char(strcat(datadir, sonars(i), '\', interv(j), '.txt'));
        
        % now let's read in the data and split out the scans
        data = splitdata(csvread(fileLocation), 4);
        
        % get individual plots
        f1 = figure;
        for x = 1:size(data, 2)
            trial = data(:,x);
            subplot(4,6,x);
            plot(trial);
            title(strcat('Trial no: ', int2str(x)));
        end
        
        % get individual plots with running average
        f2 = figure;
        for x = 1:size(data, 2)
            trial = data(:,x);
            run = runaverage(trial, 10);
            subplot(4,6,x);
            plot(run);
            title(strcat('File No.', int2str(x)));
        end
        
        % overlay all forward plots next to all backward plots
        forward = data(:,1:2:end);
        backward = data(:,2:2:end);
        f3 = figure('units','normalized','outerposition',[0 0 1 1]);
        subplot(1,2,1); plot(forward); legend(strread(num2str(1:12),'%s'));
        subplot(1,2,2); plot(backward); legend(strread(num2str(1:12),'%s'));
                
        % overlay all forward plots next to all backward plots with mean
        forward = data(:,1:2:end);
        forwardmean = mean(forward');
        backward = data(:,2:2:end);
        backwardmean = mean(backward');
        
        f4 = figure('units','normalized','outerposition',[0 0 1 1]);
        
        
        subplot(1,2,1);
        hold on;
        plot(forward, 'Color', [0 1 0 0.1]);
        plot(forwardmean, 'Color', [0 0 0 1]);
        
        subplot(1,2,2);
        hold on;
        plot(backward, 'Color', [0 1 0 0.1]);
        plot(backwardmean, 'Color', [0 0 0 1]);
        
        % overlay all plots with means
        forward = data(:,1:2:end);
        forwardmean = mean(forward');
        backward = data(:,2:2:end);
        backwardmean = mean(backward');
        
        f5 = figure('units','normalized','outerposition',[0 0 1 1]);
        
        hold on;
        plot(forward, 'Color', [0 1 0 0.1]);
        plot(forwardmean, 'Color', [1 0 0 1]);
                
        plot(fliplr(backward')', 'Color', [0 1 0 0.1]);
        plot(fliplr(backwardmean), 'Color', [0 0 1 1]);
        
        legend(strread(num2str(1:12),'%s'));
        
        % overlay all plots with means remove offsets
        offset = str2double(interv(j)) * 12;
        forward = data(offset:end,1:2:end);
        forwardmean = mean(forward');
        backward = data(offset:end,2:2:end);
        backwardmean = mean(backward');
        
        f6 = figure('units','normalized','outerposition',[0 0 1 1]);
        
        hold on;
        plot(forward, 'Color', [0 1 0 0.1]);
        plot(forwardmean, 'Color', [1 0 0 1]);
                
        plot(fliplr(backward')', 'Color', [0 1 0 0.1]);
        plot(fliplr(backwardmean), 'Color', [0 0 1 1]);
        
        legend(strread(num2str(1:12),'%s'));       
        
        % overlay all plots with mean and standard deviation
        forward = data(:,1:2:end);
        forwardmean = mean(forward');
        forwardstd = std(forward');
        
        backward = data(:,2:2:end);
        backwardmean = mean(backward');
        backwardstd = std(backward');
        f7 = figure('units','normalized','outerposition',[0 0 1 1]);
                
        subplot(1,2,1);
        hold on;
        plot(forward, 'Color', [0 1 0 0.1]);
        plot(forwardmean, 'Color', [0 0 0 1]);
        plot(forwardstd, 'Color', [1 0 0 1]);
        
        
        subplot(1,2,2);
        hold on;
        plot(backward, 'Color', [0 1 0 0.1]);
        plot(backwardmean, 'Color', [0 0 0 1]);
        plot(backwardstd, 'Color', [1 0 0 1]);
        
        
        % save all these plots
        plots = [f1 f2 f3 f4 f5 f6 f7];
        plotnames = {...
            char(strcat(sonars(i), ' - ', interv(j), ' - Raw individual results'))...
            char(strcat(sonars(i), ' - ', interv(j), ' - RunAvg individual results'))...
            char(strcat(sonars(i), ' - ', interv(j), ' - Combine seperate directional results'))...
            char(strcat(sonars(i), ' - ', interv(j), ' - Combine seperate directional results with mean'))...
            char(strcat(sonars(i), ' - ', interv(j), ' - Combine all directional results with mean'))...
            char(strcat(sonars(i), ' - ', interv(j), ' - Combine all directional results with mean removed offsets'))...
            char(strcat(sonars(i), ' - ', interv(j), ' - Combine seperate directional results with mean and standard deviation'))...
            };
        saveplots(plotdir, plots, plotnames);
        
    end    
end

