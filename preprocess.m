function newData = preprocess(data, fs, t)
%PREPROCESS Summary of this function goes here
%   Detailed explanation goes here

[m, n] = size(data);
newData = zeros(m, n);

% Baseline drift correction
%%% SMOOTHING SPLINE
for i = 1:n
    yp = createFit(t, data(:, i)');
    yp = yp(t)';
    newData(:, i) = data(:, i)'-yp;
end

% Notch 50Hz
wo = 50.3/(fs/2);  
bw = wo/35; %band width
[b,a] = iirnotch(wo,bw);
%fvtool(b,a)
newData = filtfilt(b, a, newData);

% Low pass filter
newData = lowpass(newData, 100, fs, 'ImpulseResponse', 'iir', 'Steepness', 0.95);

end

