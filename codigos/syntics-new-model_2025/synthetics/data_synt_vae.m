%% ============================================================
%   Generar datos sintéticos con una Red VAE
%   Autor: Oscar Rojas Díaz
%   Fecha: 2025-10-13
%   Descripción:
%   Entrena una red Autoencoder Variacional (VAE) sobre datos 
%   de matrices flotantes y genera nuevas muestras sintéticas.
% =============================================================

clc; clear; close all;

%% 1. Crear datos de entrenamiento
% Generamos 1000 muestras de matrices 10x10 con valores flotantes

numSamples = 1000;
dataSize = [10 10];
data = rand(numSamples, dataSize(1), dataSize(2));  % Datos aleatorios entre 0 y 1





% Reestructuramos a formato compatible con la red
X = reshape(data, [numSamples, prod(dataSize)])';  % cada columna = una muestra

%% 2. Definir dimensiones del espacio latente
latentDim = 5;  % puedes ajustar este valor

%% 3. Crear la arquitectura de la VAE

% Encoder
encoderLG = [
    featureInputLayer(prod(dataSize))
    fullyConnectedLayer(64)
    reluLayer
    fullyConnectedLayer(32)
    reluLayer
    fullyConnectedLayer(2*latentDim)  % salida: media y log-varianza
];

% Decoder
decoderLG = [
    featureInputLayer(latentDim)
    fullyConnectedLayer(32)
    reluLayer
    fullyConnectedLayer(64)
    reluLayer
    fullyConnectedLayer(prod(dataSize))
    sigmoidLayer
];

%% 4. Crear objeto dlnetwork para encoder y decoder
encoderNet = dlnetwork(encoderLG);
decoderNet = dlnetwork(decoderLG);

%% 5. Definir parámetros de entrenamiento
numEpochs = 100;
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
        
        [loss, gradsEnc, gradsDec] = dlfeval(@modelGradients, encoderNet, decoderNet, XBatch, latentDim);
        
        [encoderNet,trailingAvgEnc,averageSqGradEnc] = adamupdate(encoderNet, gradsEnc, trailingAvgEnc,averageSqGradEnc,iteration,learnRate);
        [decoderNet,trailingAvgDec,averageSqGradDec] = adamupdate(decoderNet, gradsDec, trailingAvgDec,averageSqGradDec,iteration,learnRate);
    end
    
    if mod(epoch,10)==0 || epoch==1
        disp("Época " + epoch + " | Pérdida = " + gather(extractdata(loss)));
    end
end

%% 7. Generar nuevos datos sintéticos
numNewSamples = 10;
ZNew = randn(latentDim, numNewSamples, 'single');  % muestreo del espacio latente
XNew = predict(decoderNet, dlarray(ZNew, "CB"));
XNew = extractdata(XNew);

% Reshape a formato original
syntheticData = reshape(XNew', [numNewSamples, dataSize(1), dataSize(2)]);

disp("Datos sintéticos generados con éxito.");

%% 8. Visualizar ejemplo
figure;
for i = 1:4
    subplot(2,2,i);
    mesh(syntheticData(:,:,1));
    title("Matriz sintética #" + i);
    colorbar;
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