% settings
colorFadding = [0 1 0 0.3];
colorOverlay = [0 0 0 1];
colorStd = [1 0 0 1];

% locations of folders
datadir = 'D:\Git\Data\Experiments\20172009\';
plotdir = 'D:\Git\Sonar Experiments Report\plots\20172009\';

trials = {'m1' 'm2'};
degrees = 5:5:85;

for i = 1:size(trials, 2)
    fileLocation = char(strcat(datadir, trials(i), '.txt'));
    
    % get the data
    distance = splitdata(csvread(fileLocation), 4);
    angles = splitdata(csvread(fileLocation), 3);
    
    % split it up
    forward = distance(:,1:2:end);
    backward = distance(:,2:2:end);

    % get the mean
    forwardmean = mean(forward, 2);
    backwardmean = mean(backward, 2);

    % get the standard diviation
    forwardstd = std(forward');
    backwardstd = std(backward');
    
    % get individual plots
    f1 = figure('units','normalized','outerposition',[0 0 1 1]);
    for x = 1:size(distance, 2)
        trial = distance(:,x);
        trialangles = angles(:,x);
        subplot(4,6,x);
        plot(trial);
        title(strcat('Trial no: ', int2str(x)));
    end
    
    % get individual plots with angles
    f2 = figure('units','normalized','outerposition',[0 0 1 1]);
    for x = 1:size(distance, 2)
        trial = distance(:,x);
        trialangles = angles(:,x);
        
        subplot(4,6,x);
        plot(trial);
        if i == 2
            axis([0 900 100 400]); 
            lbldegrees(trialangles, degrees, 400);
        else
            lbldegrees(trialangles, degrees, 140);
        end
        
        title(strcat('Trial no: ', int2str(x)));
    end
    
    % get individual plots with running average
    f3 = figure('units','normalized','outerposition',[0 0 1 1]);
    for x = 1:size(distance, 2)
        trial = distance(:,x);
        run = runaverage(trial, 10);
        subplot(4,6,x);
        plot(run);
        title(strcat('File No.', int2str(x)));
        
    end

    % overlay all forward plots next to all backward plots
    f4 = figure('units','normalized','outerposition',[0 0 1 1]);
    subplot(1,2,1); plot(forward); legend(strread(num2str(1:12),'%s'));
    subplot(1,2,2); plot(backward); legend(strread(num2str(1:12),'%s'));    

    % overlay all forward plots next to all backward plots with mean
    f5 = figure('units','normalized','outerposition',[0 0 1 1]);
    subplot(1,2,1); hold on;
    plot(forward, 'Color', colorFadding);
    plot(forwardmean, 'Color', colorOverlay);

    subplot(1,2,2); hold on;
    plot(backward, 'Color', colorFadding);
    plot(backwardmean, 'Color', colorOverlay);

    % overlay all plots with means
    f6 = figure('units','normalized','outerposition',[0 0 1 1]);
    hold on;
    plot(forward, 'Color', colorFadding);
    plot(forwardmean, 'Color', colorOverlay);

    plot(fliplr(backward')', 'Color', colorFadding);
    plot(fliplr(backwardmean), 'Color', colorOverlay);

    % overlay all plots with mean and standard deviation
    f7 = figure('units','normalized','outerposition',[0 0 1 1]);
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
    plots = [f1 f2 f3 f4 f5 f6 f7];
    plotnames = {...
        char(strcat(trials(i), ' - Raw individual results'))...
        char(strcat(trials(i), ' - Raw individual results with angles'))...
        char(strcat(trials(i), ' - RunAvg individual results'))...
        char(strcat(trials(i), ' - Combine seperate directional results'))...
        char(strcat(trials(i), ' - Combine seperate directional results with mean'))...
        char(strcat(trials(i), ' - Combine all directional results with mean'))...
        char(strcat(trials(i), ' - Combine seperate directional results with mean and standard deviation'))...
        };
    saveplots(plotdir, plots, plotnames);
    
end