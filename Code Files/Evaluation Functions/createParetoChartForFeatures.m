function paretoChart = createParetoChartForFeatures(data, featureName)

  paretoChart = gca;
  
  [counts, classes] = groupcounts(data);
  
  pareto(counts, string(classes))
  
  title(sprintf('Pareto Chart of %s', featureName));
  
  xlabel('Class');
  ylabel('Frequency');
  
  grid on;

end
