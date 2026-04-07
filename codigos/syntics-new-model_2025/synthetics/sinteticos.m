entrada = [datos(:,1),datos(:,3),datos(:,2)]; %346x346 valores reales suavizados
entrada = [datos(:,3),datos(:,2)]; %346x346 valores reales suavizados
max_datos=max(entrada);
entradaNorm = entrada./max_datos;
entradaNorm=entradaNorm
%entrada = fftMatrixs;
hiddenSize = 400; 
autoencI = trainAutoencoder(entradaNorm,hiddenSize,'MaxEpochs',1000);
        % 'EncoderTransferFunction','logsig',...
        % 'DecoderTransferFunction','logsig',...
         %train autoencoder

XReconstructed0AI = predict(autoencI,entradaNorm); %reconstruccion con entrada
figure; 
plot(XReconstructed0AI); %grafica reconstruccion
figure;
plot(entradaNorm); 

XReconstructed0AI = predict(autoencI,entradaNorm)*0.5; %reconstruccion con entrada
figure; 
plot(XReconstructed0AI); %grafica reconstruccion
figure;
plot(entradaNorm); 

% figure; 
% mesh(XReconstructed0AI); %grafica reconstruccion
% figure;
% mesh(entradaNorm); 