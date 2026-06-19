function paretoChart = createParetoChartForPredictors(importances, predictorNames)

  paretoChart = figure;
  
  pareto(importances, predictorNames);
  
  title('Pareto Chart of Predictor Importance');
  xlabel('Predictor');
  ylabel('Importance');
  
  grid on;

end
