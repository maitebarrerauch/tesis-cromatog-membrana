% Parámetros
latentDim = 3;
inputDim = size(X,2);
numEpochs = 200;
miniBatchSize = 32;
learningRate = 1e-4;

% Preparar datos
ds = arrayDatastore(X, 'IterationDimension',1);
mbq = minibatchqueue(ds, ...
    'MiniBatchSize', miniBatchSize, ...
    'PartialMiniBatch','discard', ...
    'OutputAsDlarray',true);

% Definir generador
genLayers = [
    featureInputLayer(latentDim,'Normalization','none','Name','genInput')
    fullyConnectedLayer(50,'Name','gen_fc1')
    reluLayer('Name','gen_relu1')
    fullyConnectedLayer(inputDim,'Name','gen_fc2')
    ];

lgraphGen = layerGraph(genLayers);
generatorNet = dlnetwork(lgraphGen);

% Definir discriminador
discLayers = [
    featureInputLayer(inputDim,'Normalization','none','Name','discInput')
    fullyConnectedLayer(50,'Name','disc_fc1')
    leakyReluLayer(0.2,'Name','disc_lrelu1')
    fullyConnectedLayer(1,'Name','disc_fc2')
    % salida escalar real/fake, se puede usar sigmoid si usas perdida binaria
    ];

lgraphDisc = layerGraph(discLayers);
discriminatorNet = dlnetwork(lgraphDisc);

% Funciones de pérdida

function [lossG, lossD, gradG, gradD] = ganLoss(generatorNet, discriminatorNet, XBatch, latentDim)
    % Generar muestras falsas
    z = randn(latentDim, size(XBatch,2), 'like', XBatch);
    Xfake = forward(generatorNet, z);
    
    % Discriminador en reales
    predReal = forward(discriminatorNet, XBatch);
    % Discriminador en falsos
    predFake = forward(discriminatorNet, Xfake);
    
    % Pérdidas: por ejemplo pérdida binaria cruzada
    lossDreal = -mean(log(sigmoid(predReal)));
    lossDfake = -mean(log(1 - sigmoid(predFake)));
    lossD = lossDreal + lossDfake;
    
    % Pérdida generador: quiere que predFake sean clasificados como reales
    lossG = - mean(log(sigmoid(predFake)));
    
    % Gradientes
    gradD = dlgradient(lossD, discriminatorNet.Learnables);
    gradG = dlgradient(lossG, generatorNet.Learnables);
end

% Entrenar
velocityG = [];
velocityD = [];
for epoch = 1:numEpochs
    reset(mbq);
    while hasdata(mbq)
        XBatch = next(mbq);
        % Asegurar tamaño adecuado
        [lossG, lossD, gradG, gradD] = ganLoss(generatorNet, discriminatorNet, XBatch, latentDim);
        % Actualizar discriminador
        [discriminatorNet, velocityD] = adamupdate(discriminatorNet, gradD, velocityD, learningRate);
        % Actualizar generador
        [generatorNet, velocityG] = adamupdate(generatorNet, gradG, velocityG, learningRate);
    end
    disp("Epoch " + epoch + ", LossD = " + extractdata(lossD) + ", LossG = " + extractdata(lossG));
end

% Generar muestras sintéticas
numSynthetic = 100;
zSample = randn(latentDim, numSynthetic, 'single');
X_synth_GAN = predict(generatorNet, zSample)';  % nueva data generada