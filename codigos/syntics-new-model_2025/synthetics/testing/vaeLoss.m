% Función de pérdida
function [loss, gradientsEnc, gradientsDec] = vaeLoss(encoderNet, decoderNet, XBatch,latentDim)
    % Forward Encoder
    zParams = forward(encoderNet, XBatch);
    mu = zParams(:, 1:latentDim);
    logVar = zParams(:, latentDim+1:end);
    sigma = exp(0.5 * logVar);

    % Reparametrización: mu + sigma .* epsilon
    epsilon = randn(size(sigma), 'like', sigma);
    z = mu + sigma .* epsilon;
    
    % Decodificar
    XPred = forward(decoderNet, z)


    %% % Decoder output
    %% xPred = forward(decoderNet, reshape(z, [1 1 latentDim size(x,4)]));

    XBatch
    % Pérdida de reconstrucción (por ejemplo MSE)
    % Specify the DataFormat
    options.DataFormat = 'U'; % or 'CB', depending on your data structure
    
    % Calculate the mean squared error
    reconLoss = mse(dlarray(XPred,'CB'), dlarray(XBatch,'CB'));

   % reconLoss = mse(XPred, XBatch)
    
    % Pérdida KL divergence (con distribución normal estándar)
    klLoss = -0.5 * sum(1 + logVar - mu.^2 - exp(logVar), 'all') / numel(mu);
    
    loss = reconLoss + klLoss;
    
    % Calcular gradientes
    gradientsEnc = dlgradient(loss, encoderNet.Learnables);
    gradientsDec = dlgradient(loss, decoderNet.Learnables);
end