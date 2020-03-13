function multiPlot(t, data, plot_title, xLabel, yLabel)
%PLOT2CH Summary of this function goes here
%   Detailed explanation goes here

if nargin < 5
    yLabel = 'y';
end
if nargin < 4
    xLabel = 'x';
end
if nargin < 3
    plot_title = 'Title';
end

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

