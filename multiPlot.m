function multiPlot(t, data, plot_title, xLabel, yLabel)
%PLOT2CH Summary of this function goes here
%   Detailed explanation goes here

n = size(data, 2);

figure
for i = 1:n
    subplot(n,1,i)
    plot(t, data(:,i))
    xlabel(xLabel)
    ylabel(yLabel)
    title([plot_title ' - ' num2str(i)])
end
hold off

end

