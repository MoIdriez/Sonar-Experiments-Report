% settings
colorFadding = [0 1 0 0.3];
colorOverlay = [0 0 0 1];
colorStd = [1 0 0 1];

% locations of folders
datadir = 'D:\Git\Data\Experiments\20161117\1 - Scaling\';
plotdir = 'D:\Git\Sonar Experiments Report\plots\20161117\Scaling\DScalingIndividual\';

scaling = {'D' 'D2' 'D3'};
sonars = {'EZ' 'EZ1' 'EZBrown'};

for j = 1:size(scaling, 2)    
    for i = 1:size(sonars, 2)    
        fileLocation = char(strcat(datadir, scaling(j), '\', sonars(i), '\data.txt'));

        % get the data
        data = splitdata(csvread(fileLocation), 2);

        % split it up
        forward = data(:,1:2:end);
        backward = data(:,2:2:end);

        % get the mean
        forwardmean = mean(forward, 2);
        backwardmean = mean(backward, 2);

        % get the standard diviation
        forwardstd = std(forward');
        backwardstd = std(backward');

        % get individual plots
        f1 = figure('units','normalized','outerposition',[0 0 1 1]);
        for x = 1:size(data, 2)
            trial = data(:,x);
            subplot(4,6,x);
            plot(trial);
            title(strcat('Trial no: ', int2str(x)));
        end

        % get individual plots with running average
        f2 = figure('units','normalized','outerposition',[0 0 1 1]);
        for x = 1:size(data, 2)
            trial = data(:,x);
            run = runaverage(trial, 10);
            subplot(4,6,x);
            plot(run);
            title(strcat('File No.', int2str(x)));
        end

        % overlay all forward plots next to all backward plots
        f3 = figure('units','normalized','outerposition',[0 0 1 1]);
        subplot(1,2,1); plot(forward); legend(strread(num2str(1:12),'%s'));
        subplot(1,2,2); plot(backward); legend(strread(num2str(1:12),'%s'));    

        % overlay all forward plots next to all backward plots with mean
        f4 = figure('units','normalized','outerposition',[0 0 1 1]);
        subplot(1,2,1); hold on;
        plot(forward, 'Color', colorFadding);
        plot(forwardmean, 'Color', colorOverlay);

        subplot(1,2,2); hold on;
        plot(backward, 'Color', colorFadding);
        plot(backwardmean, 'Color', colorOverlay);

        % overlay all plots with means
        f5 = figure('units','normalized','outerposition',[0 0 1 1]);
        hold on;
        plot(forward, 'Color', colorFadding);
        plot(forwardmean, 'Color', colorOverlay);

        plot(fliplr(backward')', 'Color', colorFadding);
        plot(fliplr(backwardmean), 'Color', colorOverlay);

        % overlay all plots with mean and standard deviation
        f6 = figure('units','normalized','outerposition',[0 0 1 1]);
        subplot(1,2,1);
        hold on;
        plot(forward, 'Color', colorFadding);
        plot(forwardmean, 'Color', colorOverlay);
        plot(forwardstd, 'Color', colorStd);


        subplot(1,2,2);
        hold on;
        plot(backward, 'Color', colorFadding);
        plot(backwardmean, 'Color', colorOverlay);
        plot(backwardstd, 'Color', colorStd);

        % save all these plots
        plots = [f1 f2 f3 f4 f5 f6];
        plotnames = {...
            char(strcat(scaling(j), ' - ', sonars(i), ' - Raw individual results'))...
            char(strcat(scaling(j), ' - ', sonars(i), ' - RunAvg individual results'))...
            char(strcat(scaling(j), ' - ', sonars(i), ' - Combine seperate directional results'))...
            char(strcat(scaling(j), ' - ', sonars(i), ' - Combine seperate directional results with mean'))...
            char(strcat(scaling(j), ' - ', sonars(i), ' - Combine all directional results with mean'))...
            char(strcat(scaling(j), ' - ', sonars(i), ' - Combine seperate directional results with mean and standard deviation'))...
            };
        saveplots(plotdir, plots, plotnames);
    end
end