datadir = 'D:\Git\Data\Experiments\20161114\EZ Brown\Corner15\';
plotdir = 'D:\Git\Sonar Experiments Report\plots\20161114\EZ Brown Corner 15\';
%% plot individiual - EZ Corner
f1 = figure;
for i = 1:10
    trial = csvread(strcat(datadir, int2str(i), '.txt'));
    subplot(2,5,i);
    plot(trial(:,2))
    title(strcat('File No.', int2str(i)));
end

%% plot individual - EZ Corner Running average
f2 = figure;
for i = 1:10
    trial = csvread(strcat(datadir, int2str(i), '.txt'));
    run = runaverage(trial, 10);
    subplot(2,5,i);
    plot(run(:,2));
    title(strcat('File No.', int2str(i)));
end

%% plot indiviual - EZ Corner Running average overlay
f3 = figure;
hold on;
for i = 1:10
    trial = csvread(strcat(datadir, int2str(i), '.txt'));
    run = runaverage(trial, 10);
    plot(run(:,2));
    title(strcat('File No.', int2str(i)));
end
hold off;
legend(strread(num2str(1:10),'%s'));


%% plot indiviual - EZ Corner Running average overlay
%start = [710 664 784 761 600 723 791 727 868 634];
data = combinedata(strcat(datadir), 10, 1780, 10);
avg = mean(data);
f4 = figure;
hold on;
plot(avg, 'Color', [0 0 0 1]);
for i = 1:10
    plot(data(i,:), 'Color', [0 1 0 0.2]);
end
hold off;

%% save the generated plots
plots = [f1 f2 f3 f4];
plotnames = {...
    'Raw individual results'...
    'RunAvg individual results'...
    'RunAvg overlay results'...
    'RunAvg overlay results with mean'...
    };

% save the default plots
saveplots(plotdir, plots, plotnames);

