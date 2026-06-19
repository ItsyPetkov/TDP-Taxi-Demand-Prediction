function results = evaluateModel(model, data, responseName)

    % Split predictors/response
    Y = data.(responseName);
    X = removevars(data, string(responseName));

    % Predict
    yPred = model.predictFcn(X);

    % Confusion matrix
    [C, order] = confusionmat(Y, yPred);

    % Plot confusion matrix
    figure
    confusionchart(C, order);
    title('Confusion Matrix');

    N = sum(C(:));

    % Overall accuracy
    results.Accuracy = sum(diag(C)) / N;

    % Per-class metrics (one-vs-rest)
    TP = diag(C);
    FP = sum(C,1)' - TP;
    FN = sum(C,2)  - TP;
    TN = N - TP - FP - FN;

    Precision   = TP ./ (TP + FP);
    Recall      = TP ./ (TP + FN);     % TPR / Sensitivity
    Specificity = TN ./ (TN + FP);
    FPR         = FP ./ (FP + TN);
    FDR         = FP ./ (FP + TP);
    F1          = 2 .* (Precision .* Recall) ./ (Precision + Recall);

    % Handle divide-by-zero cases
    Precision(isnan(Precision))     = 0;
    Recall(isnan(Recall))           = 0;
    Specificity(isnan(Specificity)) = 0;
    FPR(isnan(FPR))                 = 0;
    FDR(isnan(FDR))                 = 0;
    F1(isnan(F1))                   = 0;

    % Per-class results table
    results.PerClass = table( ...
        order, TP, FP, FN, TN, ...
        Precision, Recall, Specificity, FPR, FDR, F1, ...
        'VariableNames', { ...
        'Class','TP','FP','FN','TN', ...
        'Precision','Recall','Specificity','FPR','FDR','F1'});

    % Macro averages
    results.MacroPrecision   = mean(Precision);
    results.MacroRecall      = mean(Recall);
    results.MacroSpecificity = mean(Specificity);
    results.MacroF1          = mean(F1);
    results.MacroFPR         = mean(FPR);
    results.MacroFDR         = mean(FDR);

    % Weighted averages
    support = sum(C,2);

    results.WeightedPrecision = sum(Precision .* support) / sum(support);
    results.WeightedRecall    = sum(Recall .* support) / sum(support);
    results.WeightedF1        = sum(F1 .* support) / sum(support);

    % Store confusion matrix
    results.ConfusionMatrix = C;
    results.ClassOrder      = order;

end
