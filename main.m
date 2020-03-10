clear; clc; close all;
load fecg1.dat
load mecg1.dat
load noise1.dat

fs = 256; % Sampling rate
N=length(fecg1); 
t=0:1/fs:(N-1)/fs; % time line for plotting
%%
% Plots to show original signals
sp1 = subplot(4,1,1)
plot(t,mecg1)
sp2 = subplot(4,1,2)
plot(t,fecg1)
sp3 = subplot(4,1,3)
plot(t,noise1)

% New signal where all three are merged
ecg = mecg1+fecg1+noise1;
sp4 = subplot(4,1,4)
plot(t,ecg)

linkaxes([sp1,sp2, sp3, sp4],'y'); % scales all the same

%%
% plots the power estimate
figure
pwelch(mecg1)
figure
pwelch(fecg1)
figure
pwelch(noise1)

%calculate mean
mean_mecg1=mean(mecg1);
mean_fecg1=mean(fecg1);
mean_noise1=mean(noise1);
% calculate variance
var_mecg1=var(mecg1);
var_fecg1=var(fecg1);
var_noise1=var(noise1);

%%
%Plots histogram and calculate the kurtosis etc
figure
hist(mecg1,100)
figure
hist(fecg1,100)
figure
hist(noise1,100)

%kurtosis is the measure of how heavy the tails are
kurtosis(mecg1)
kurtosis(fecg1)
kurtosis(noise1)
%comparing the kurtosis with the histogram the numbers make sense.
%Kurotosis of the normal distribution is 3. Values higher than 3 have
%heavier tails than normal distribution. Obviouslt the error is normaly
%distributed (it is visible from the hist but also the kurtosis is close to
%3)
%%
% Filtering with PCA (Here all signals are mixed in X)

addpath('lab5files/matlab');

load lab5files/data/X.dat

fs = 256; % Sampling rate
N=length(X); 
t=0:1/fs:(N-1)/fs; % time line for plotting

plot3ch(X)

[U,S,V] = svd(X);


plot3dv(V(:,1),S(1,1));
plot3dv(V(:,2),S(2,2));
plot3dv(V(:,3),S(3,3));

figure
sp1 = subplot(3,1,1)
plot(t,U(:,1))
sp2 = subplot(3,1,2)
plot(t,U(:,2))
sp3 = subplot(3,1,3)
plot(t,U(:,3))

%eigenspectrum
figure
stem([S(1,1),S(2,2),S(3,3)])

% Change in Sforreconstruct to fix what channel you want to plot
SForReconstruct = S;
SForReconstruct(1,1)=0;
SForReconstruct(3,3)=0;

YReconstruct = U*SForReconstruct*V';

plot(YReconstruct)
%%
% Using ICA
[W, Zhat] = ica(X');
WInv = inv(W);

%independent components
plot3ch(Zhat')


plot3dv(WInv(:,1));
plot3dv(WInv(:,2));
plot3dv(WInv(:,3));

figure
sp1 = subplot(3,1,1)
plot(t,Zhat(1,:))
sp2 = subplot(3,1,2)
plot(t,Zhat(2,:))
sp3 = subplot(3,1,3)
plot(t,Zhat(3,:))

%reconstruction
%the third signal is the fetal ECG
WInvReconstruct = WInv;
WInvReconstruct(:,1)=0;
WInvReconstruct(:,2)=0;

XReconstruct = (WInvReconstruct * Zhat)';

plot3ch(XReconstruct)
%%
% Matlabs ICA*
Wrica = rica(X,3); %rica(data,2)
Zhatrica = transform(Wrica,X);

plot3ch(Zhatrica)

[W, Zhat] = ica(X');
WInv = inv(W);

%our independent components
plot3ch(Zhat')
