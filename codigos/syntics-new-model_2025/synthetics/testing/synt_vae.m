% % Generate synthetic float data
% numSamples = 1000;
% data = rand(numSamples, 10); % 1000 samples with 10 float features
% %data = entradaNorm
% % Define VAE architecture
% numLatentDimensions = 5; % Size of the latent space
% 
% % Encoder
% layersE = [
%     featureInputLayer(10) % Input layer for 10 features
%     fullyConnectedLayer(20) % Hidden layer
%     reluLayer
%     fullyConnectedLayer(2 * numLatentDimensions) % Output means and log variances
% ];
% 
% % Decoder
% layersD = [
%     featureInputLayer(numLatentDimensions) % Input layer for latent space
%     fullyConnectedLayer(20) % Hidden layer
%     reluLayer
%     fullyConnectedLayer(10) % Output layer to reconstruct original data
%     ];
% 
% % Combine Encoder and Decoder into a VAE
% layers = [layersE; layersD];
% 
% % Training options
% options = trainingOptions('adam', ...
%     'MaxEpochs', 100, ...
%     'MiniBatchSize', 128, ...
%     'Verbose', false, ...
%     'Plots', 'training-progress');
% 
% % Train the VAE
% vaeNet = trainnet(data, layers, options);
% 
% % Generate Synthetic Data
% numSyntheticSamples = 100; % Number of synthetic samples to generate
% latentSamples = randn(numSyntheticSamples, numLatentDimensions); % Sample from a standard normal distribution
% generatedData = predict(vaeNet, latentSamples); % Generate data from latent samples
% 
% % Display generated data
% disp(generatedData);

N=10;
D = 100
X = randn(N, D);  % N ejemplos, cada uno de dimensión D


% Parámetros
latentDim = 3;   % dimensión del espacio latente
inputDim = size(X,2);
numEpochs = 100;
miniBatchSize = 32;
learningRate = 1e-3;

% Preparar datos como `dlarray` si usas redes con auto diferenciación
ds = arrayDatastore(X, 'IterationDimension',1);
mbq = minibatchqueue(ds, ...
    'MiniBatchSize', miniBatchSize, ...
    'PartialMiniBatch','discard', ...
    'OutputAsDlarray',true);

% Definir encoder
encoderLayers = [
    featureInputLayer(inputDim, 'Normalization', 'none', 'Name','encoderInput')
    fullyConnectedLayer(50, 'Name','enc_fc1')
    reluLayer('Name','enc_relu1')
    fullyConnectedLayer(2*latentDim, 'Name','enc_fc2')  % salidas mu y logvar
    ];

lgraphEnc = layerGraph(encoderLayers);

% Definir decoder
decoderLayers = [
    featureInputLayer(latentDim, 'Normalization','none','Name','decoderInput')
    fullyConnectedLayer(50, 'Name','dec_fc1')
    reluLayer('Name','dec_relu1')
    fullyConnectedLayer(inputDim, 'Name','dec_fc2')
    % Sin activación o con activación apropiada (por ej lineal si datos continuos)
    ];

lgraphDec = layerGraph(decoderLayers);

% Convertir a dlnetworks para entrenamiento personalizado
encoderNet = dlnetwork(lgraphEnc);
decoderNet = dlnetwork(lgraphDec);
%% test oscar
%[Y,state] = forward(encoderNet,X);



%% Fin test oscar
% Entrenamiento (simplificado)
velocityEnc = [];
velocityDec = [];
for epoch = 1:numEpochs
    reset(mbq);
    while hasdata(mbq)
        XBatch = next(mbq);
        %XBatch
        % Asegúrate que XBatch sea dlarray de tamaño [inputDim, batchSize]
       [loss, gradEnc, gradDec] = vaeLoss(encoderNet, decoderNet, XBatch,latentDim);
       %  [loss, gradEnc, gradDec] = modelLoss(encoderNet, decoderNet, XBatch,latentDim);

        % Actualizar pesos con ADAM u otro optimizador
        [encoderNet, velocityEnc] = adamupdate(encoderNet, gradEnc, velocityEnc, learningRate);
        [decoderNet, velocityDec] = adamupdate(decoderNet, gradDec, velocityDec, learningRate);
    end
    disp("Epoch " + epoch + ", Loss = " + extractdata(loss));
end

% Generar datos sintéticos
numSynthetic = 100;
zSample = randn(latentDim, numSynthetic, 'single');  % muestras de la distribución latente
X_synth = predict(decoderNet, zSample)';  % Transponer si corresponde