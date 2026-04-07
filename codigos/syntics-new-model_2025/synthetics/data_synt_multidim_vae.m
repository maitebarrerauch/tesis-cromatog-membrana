%% ============================================================
%   Generar datos sintéticos con una Red VAE
%   Autor: Oscar Rojas Díaz
%   Fecha: 2025-10-13
%   Descripción:
%   Entrena una red Autoencoder Variacional (VAE) sobre datos 
%   de matrices flotantes y genera nuevas muestras sintéticas.
% =============================================================

useGPU        = true;

%% == Comprobar GPU ==
if useGPU
    try
        gcount = gpuDeviceCount;
        if gcount == 0
            warning('No hay GPUs disponibles. Se entrenará en CPU.');
            useGPU = false;
        else
            gpuDevice(1); % seleccionar la primera GPU
            disp("GPU detectada y seleccionada.");
        end
    catch ME
        warning("Error al inicializar GPU: " + ME.message + " → entrenando en CPU.");
        useGPU = false;
    end
end




%% 1. Crear datos de entrenamiento
% Generamos 1000 muestras de matrices 10x10 con valores flotantes

% numSamples = 10;
% dataSize = [10 2];
% data = rand(numSamples, dataSize(1), dataSize(2));  % Datos aleatorios entre 0 y 1
% 
% data = diff(I_surf_cuadrada)';

%% Usando CUM
%data = cat(3, I_surf_cuadrada', R_surf_cuadrada', F_surf_cuadrada', U_surf_cuadrada');

%% Usando diaria
data = cat(3, X_train');
% numSamples = size(data,1);
% dataSize = [1,size(data,2)]';
% 
% [numSamples, rows, cols] = size(data)
% 
% % Reestructuramos a formato compatible con la red
% X = reshape(data, [numSamples, prod(dataSize)])';  % cada columna = una muestra

[numSamples, rows, cols] = size(data);
dataSize = [rows cols];


% Normalización min-max
minVal = min(data(:));
maxVal = max(data(:));
% dataNorm = (data - minVal) / (maxVal - minVal);
dataNorm = rescale(data, 0, 1);

% Aplanar cada matriz a un vector columna
X = reshape(dataNorm, [numSamples, rows*cols]);

% Transponer: cada columna es una muestra
X = X';   % tamaño final [numFeatures × numSamples]


%% 2. Definir dimensiones del espacio latente
latentDim = 5;  % puedes ajustar este valor

%% 3. Crear la arquitectura de la VAE
dim1 = 128/4;
dim2 = 64/4;
% Encoder
encoderLG = [
    featureInputLayer(prod(dataSize))
    fullyConnectedLayer(dim1)
    reluLayer
    fullyConnectedLayer(dim2)
    reluLayer
    fullyConnectedLayer(2*latentDim)  % salida: media y log-varianza
];

% Decoder
decoderLG = [
    featureInputLayer(latentDim)
    fullyConnectedLayer(dim2)
    reluLayer
    fullyConnectedLayer(dim1)
    reluLayer
    fullyConnectedLayer(prod(dataSize))
    sigmoidLayer
];

%% 4. Crear objeto dlnetwork para encoder y decoder
encoderNet = dlnetwork(encoderLG);
decoderNet = dlnetwork(decoderLG);

%% 5. Definir parámetros de entrenamiento
numEpochs = 5000;
miniBatchSize = 128;
learnRate = 1e-3;

trailingAvgEnc = [];
trailingAvgDec = [];
averageSqGradEnc = [];
averageSqGradDec = [];

%% 6. Entrenamiento de la VAE
disp("Entrenando la red VAE...");
iteration = 0;
for epoch = 1:numEpochs
    idx = randperm(numSamples);
    X = X(:, idx);
    
    for i = 1:miniBatchSize:numSamples
        iteration = iteration + 1;
        idxBatch = i:min(i+miniBatchSize-1, numSamples);
        XBatch = dlarray(X(:, idxBatch), "CB");
        if useGPU
            XBatch = gpuArray(XBatch);
        end
        [loss, gradsEnc, gradsDec] = dlfeval(@modelGradients, encoderNet, decoderNet, XBatch, latentDim);
        
        [encoderNet,trailingAvgEnc,averageSqGradEnc] = adamupdate(encoderNet, gradsEnc, trailingAvgEnc,averageSqGradEnc,iteration,learnRate);
        [decoderNet,trailingAvgDec,averageSqGradDec] = adamupdate(decoderNet, gradsDec, trailingAvgDec,averageSqGradDec,iteration,learnRate);
    end
    
    if mod(epoch,10)==0 || epoch==1
        disp("Época " + epoch + " | Pérdida = " + gather(extractdata(loss)));
    end
end




%% --- Función auxiliar para calcular gradientes ---
function [loss, gradsEnc, gradsDec] = modelGradients(encoderNet, decoderNet, x, latentDim)
    % Pasar por encoder
    zParams = forward(encoderNet, x);
    mu = zParams(1:latentDim, :);
    logVar = zParams(latentDim+1:end, :);
    
    % Reparametrización
    epsilon = randn(size(mu), 'like', mu);
    z = mu + exp(0.5 * logVar) .* epsilon;
    
    % Pasar por decoder
    xPred = forward(decoderNet, z);
    
    % Pérdida de reconstrucción (MSE)
    reconLoss = mse(xPred, x);
    
    % Divergencia KL
    klLoss = -0.5 * sum(1 + logVar - mu.^2 - exp(logVar), 1);
    klLoss = mean(klLoss);
    
    % Pérdida total
    loss = reconLoss + 0.01 * klLoss;  % peso KL pequeño para estabilidad
    
    % Gradientes
    gradsEnc = dlgradient(loss, encoderNet.Learnables);
    gradsDec = dlgradient(loss, decoderNet.Learnables);
end