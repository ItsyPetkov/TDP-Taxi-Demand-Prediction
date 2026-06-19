addpath '/MATLAB Drive/Predictive Modeling and Machine Learning/Code Files/Evaluation Functions';

taxiData = loadAndProcessTaxiData("Taxi Data");

entireTaxiData = vertcat(taxiData{:});

initialExploratoryDataAnalysis;

entireTaxiDataCleaned = basicPreprocessing(entireTaxiData);
clear entireTaxiData taxiData;

postCleaningExploratoryDataAnalysis;

clear currentVars endIdx f j nPlots numFigures startIdx varsPerFigure;

featureEngineering;

featureSelection;

% Machine Learning part

% Baseline model (Scenario 1)

Mdl = trainBaselineClassifier(trainData);

resultsS1 = evaluateModel(Mdl, trainData, "Demand")

resultsS1Tested = evaluateModel(Mdl, testData, "Demand")

% Best Baseline model (Scenario 1.5)

Mdl1_5 = trainPostFeatureEngineeringBaselineClassifier(trainData);

resultsS1_5 = evaluateModel(Mdl1_5, trainData, "Demand")

resultsS1_5Tested = evaluateModel(Mdl1_5, testData, "Demand")

% Best model (Scenario 2)

Mdl_2 = trainWideNeuralNetworkClassifier(trainData);

resultsS2 = evaluateModel(Mdl_2, trainData, "Demand")

resultsS2Tested = evaluateModel(Mdl_2, testData, "Demand")
