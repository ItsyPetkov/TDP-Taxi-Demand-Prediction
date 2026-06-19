addpath '/MATLAB Drive/Predictive Modeling and Machine Learning/Code Files/Training Functions';

% Filter-based feature selection using fscmrmr
% Remove unwanted predictors first
predictors = removevars(groupedSummaryTable, ...
    {'HourlyBin', 'Region', 'IsHoliday'});

% Separate features and response
X = removevars(predictors, 'Demand');
y = predictors.Demand;

% Run MRMR
idx = fscmrmr(X, y);

% Get feature names
featNames = X.Properties.VariableNames;

% Sort in descending order of importance
[sortedIdx, sortOrder] = sort(idx, 'descend');
sortedNames = featNames(sortOrder);

% Plot
figure('Position', [100, 100, 1400, 500]);
bar(sortedIdx);

xticks(1:length(sortedIdx));
xticklabels(sortedNames);
xtickangle(45);

xlabel('Feature');
ylabel('MRMR Score');
title('Feature Importance Ranking (MRMR)');
grid on;

rng(42);

cv = cvpartition(height(groupedSummaryTable), 'HoldOut', 0.20);

trainData = groupedSummaryTable(training(cv), :);
testData  = groupedSummaryTable(test(cv), :);

Mdl = trainBaselineClassifier(trainData);

resultsS1 = evaluateModel(Mdl, trainData, "Demand")

resultsS1Tested = evaluateModel(Mdl, testData, "Demand")

imp = predictorImportance(Mdl.ClassificationEnsemble);

createParetoChartForPredictors(imp, Mdl.ClassificationEnsemble.PredictorNames);

Mdl1_5 = trainPostFeatureEngineeringBaselineClassifier(trainData);

resultsS1_5 = evaluateModel(Mdl1_5, trainData, "Demand")

resultsS1_5Tested = evaluateModel(Mdl1_5, testData, "Demand")

imp1_5 = predictorImportance(Mdl1_5.ClassificationEnsemble);
names = string(Mdl1_5.ClassificationEnsemble.PredictorNames);

[impSorted, idx] = sort(imp1_5, 'descend');
namesSorted = names(idx);

createParetoChartForPredictors(impSorted, namesSorted);
