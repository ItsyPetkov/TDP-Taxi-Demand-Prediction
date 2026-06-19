% Post cleaning exploratory data analysis
for i = 1:width(entireTaxiDataCleaned) 

    feature = entireTaxiDataCleaned.(i); 

    if isa(feature, 'double') 

        figure('Position',[100 100 1400 500]);

        subplot(1,2,1);
        createHistogram(feature, entireTaxiDataCleaned.Properties.VariableNames{i}); % Histograms 

        subplot(1,2,2);
        createBoxPlot(feature, entireTaxiDataCleaned.Properties.VariableNames{i}); % BoxPlots 
    end 
end

% Identify categorical variables
varTypes = varfun(@class, entireTaxiDataCleaned, 'OutputFormat', 'cell');
catVars = strcmp(varTypes, 'categorical') | strcmp(varTypes, 'string');
catNames = entireTaxiDataCleaned.Properties.VariableNames(catVars);

varsPerFigure = 2;   % 2 charts per figure
numFigures = ceil(length(catNames) / varsPerFigure);

for f = 1:numFigures

    figure('Position',[100 100 1600 700]);

    t = tiledlayout(1,2, ...
        'TileSpacing','loose', ...
        'Padding','loose');

    startIdx = (f-1)*varsPerFigure + 1;
    endIdx = min(f*varsPerFigure, length(catNames));

    currentVars = catNames(startIdx:endIdx);
    nPlots = length(currentVars);

    for j = 1:nPlots

        featureName = currentVars{j};
        featureData = rmmissing(entireTaxiDataCleaned.(featureName));

        subplot(1, varsPerFigure, j);
        createParetoChartForFeatures(featureData, featureName);

    end

end

clear feature featureData featureName varTypes catVars catNames i ans numClasses;

summary(entireTaxiDataCleaned)

createCorrelationHeatmap(entireTaxiDataCleaned);

clear ans;

pairs = {
    'Distance','Fare';
    'Fare','TotalCharge';
    'Distance','Duration';
    'Duration','TotalCharge';
    'Fare','Tip';
    'TotalCharge','Tip'
    };

figure('Position', [100, 100, 800, 900]);
tiledlayout(3,2);

for k = 1:size(pairs,1)

    nexttile;

    scatter(entireTaxiDataCleaned.(pairs{k,1}), ...
            entireTaxiDataCleaned.(pairs{k,2}), '.');

    xlabel(pairs{k,1});
    ylabel(pairs{k,2});
    title(sprintf('%s vs %s', pairs{k,2}, pairs{k,1}));
    grid on;

end

clear k pairs t;
