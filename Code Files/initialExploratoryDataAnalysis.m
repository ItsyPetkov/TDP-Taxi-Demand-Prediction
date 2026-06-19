% Get an initial feel for the data through the summary function
summary(entireTaxiData)

for i = 1:width(entireTaxiData) 

    feature = entireTaxiData.(i); 

    if isa(feature, 'double') 

        figure('Position',[100 100 1400 500]);

        subplot(1,2,1);
        createHistogram(feature, entireTaxiData.Properties.VariableNames{i}); % Histograms 

        subplot(1,2,2);
        createBoxPlot(feature, entireTaxiData.Properties.VariableNames{i}); % BoxPlots 
    end 
end

% Identify categorical variables
varTypes = varfun(@class, entireTaxiData, 'OutputFormat', 'cell');
catVars = strcmp(varTypes, 'categorical') | strcmp(varTypes, 'string');
catNames = entireTaxiData.Properties.VariableNames(catVars);

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
        featureData = rmmissing(entireTaxiData.(featureName));

        subplot(1, varsPerFigure, j);
        createParetoChartForFeatures(featureData, featureName);

    end

end

clear feature featureData featureName varTypes catVars catNames i f j t ans ...
    currentVars endIdx nPlots numFigures startIdx varsPerFigure;
