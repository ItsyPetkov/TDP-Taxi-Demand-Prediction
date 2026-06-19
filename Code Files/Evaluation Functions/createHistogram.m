function histfigure = createHistogram(feature, featureName)

    histfigure = gca;
    histogram(feature);

    title(sprintf('%s Distribution', featureName));
    xlabel(featureName);
    ylabel('Frequency');
    grid on;

    m   = mean(feature,'omitnan');
    med = median(feature,'omitnan');

    q = quantile(feature,[0.25 0.75]);
    q1 = q(1);
    q3 = q(2);

    xline(m,  'Color','r', 'Label','Mean',   'LabelVerticalAlignment','middle');
    xline(med,'Color','b', 'Label','Median', 'LabelVerticalAlignment','middle');
    xline(q1, '--g',       'Label','Q1');
    xline(q3, '--g',       'Label','Q3');
end
