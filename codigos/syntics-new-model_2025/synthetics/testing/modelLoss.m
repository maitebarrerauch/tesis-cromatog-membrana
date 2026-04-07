function [loss, gradientsEnc, gradientsDec] = modelLoss(encoderNet, decoderNet, x, latentDim)
    % Forward Encoder
    zParams = forward(encoderNet, x);
    mu = zParams(:, 1:latentDim);
    logVar = zParams(:, latentDim+1:end);
    sigma = exp(0.5 * logVar);

    % Reparametrización: mu + sigma .* epsilon
    epsilon = randn(size(sigma), 'like', sigma);
    z = mu + sigma .* epsilon;

    % Decoder output
    xPred = forward(decoderNet, z);

    % Reconstrucción Loss
    reconLoss = mse(xPred, x);

    % KL Divergence
    klLoss = -0.5 * sum(1 + logVar - mu.^2 - exp(logVar), 2);
    klLoss = mean(klLoss);

    % Total Loss
    loss = reconLoss + klLoss;

    % Gradientes
    gradientsEnc = dlgradient(loss, encoderNet.Learnables);
    gradientsDec = dlgradient(loss, decoderNet.Learnables);

  %  gradients = {gradientsEncoder, gradientsDecoder};
end