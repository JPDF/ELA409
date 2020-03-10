clear; clc; close all;
load data\Emma_EMG_ChestFlex_Leads.csv
X = Emma_EMG_ChestFlex_Leads;

fs = 512; % Sampling rate
N=length(X); 
t=0:1/fs:(N-1)/fs; % time line for plotting

figure (1)
plot(t, X)


%% 
a = rica(X,2)
Z = transform(a,X);

figure (2)
sp1 = subplot(2,1,1)
plot(t, Z(:,1))
sp2 = subplot(2,1,2)
plot(t, Z(:,2))