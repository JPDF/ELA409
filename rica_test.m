clear; clc; close all;
load data\FullFlex_Julia_Leads.csv
X = FullFlex_Julia_Leads;

fs = 512; % Sampling rate
N=length(FullFlex_Julia_Leads); 
t=0:1/fs:(N-1)/fs; % time line for plotting

figure (1)
plot(t, X(:,1))
hold on
plot(t, X(:,2))


%% 
a = rica(X,2)
Z = transform(a,X);

figure (2)
sp1 = subplot(2,1,1)
plot(t, Z(:,1))
sp2 = subplot(2,1,2)
plot(t, Z(:,2))