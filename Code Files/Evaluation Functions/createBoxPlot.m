function fig = createBoxPlot(feature, featureName)

  fig = gca;
  
  boxplot(feature);
  
  title(sprintf('Box Plot of %s', featureName));
  ylabel(featureName);
  
  q = quantile(feature,[0.25 0.5 0.75]);
  
  fprintf('\n%s\n', featureName);
  fprintf('Q1     : %.2f\n', q(1));
  fprintf('Median : %.2f\n', q(2));
  fprintf('Q3     : %.2f\n', q(3));
  fprintf('IQR    : %.2f\n', q(3)-q(1));
  
  grid on;

end
