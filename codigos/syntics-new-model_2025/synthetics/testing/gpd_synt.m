% Load your data
%load('Data_GlobalIdx1.mat'); % Replace with your actual data file
data = entradaNorm
% Fit a Generalized Pareto Distribution (GPD) to the tail
threshold = prctile(data, 95); % Define a threshold
gpdParams = fitgpd(data(data > threshold), 'Upper', threshold);

% Generate synthetic data using the fitted GPD
syntheticData = random(gpdParams, 1000, 1); % Generate 1000 synthetic samples

% Fit a copula to model dependencies
copulaModel = copulafit('Gaussian', data); % Fit a Gaussian copula
syntheticDataWithDependence = copularnd(copulaModel, 1000); % Generate correlated synthetic data