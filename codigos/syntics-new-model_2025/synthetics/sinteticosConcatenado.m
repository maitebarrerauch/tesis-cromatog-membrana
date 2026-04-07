close all
entrada = [datos(:,1),datos(:,3),datos(:,2)]; %346x346 valores reales suavizados
entrada = [datos(:,3),datos(:,2)]; %346x346 valores reales suavizados
max_datos=max(entrada);
entradaNorm = entrada./max_datos;
xSize = size(entradaNorm,1);
figure;
plot(entradaNorm);
input = entradaNorm;

entradaNorm=[entradaNorm(:,1);entradaNorm(:,2)];
%entrada = fftMatrixs;
hiddenSize = 20; 
% Supongamos que los datos originales son 'X'
noiseLevel = 0.1; % Nivel de ruido (puedes ajustarlo)
X_noisy = entradaNorm + noiseLevel * randn(size(entradaNorm)); % Agregar ruido gaussiano
autoenc = trainAutoencoder(entradaNorm,hiddenSize,'MaxEpochs',1000,'L2WeightRegularization', 0.01,'SparsityRegularization', 40,'SparsityProportion', 0.009,...
         'EncoderTransferFunction','satlin',...
         'DecoderTransferFunction','purelin');
         %train autoencoder

%autoenc = trainAutoencoder(X_noisy,hiddenSize,'MaxEpochs',1000,'L2WeightRegularization', 0.01,'SparsityRegularization', 1,'SparsityProportion', 0.05);


XReconstructed0AI = predict(autoenc,entradaNorm); %reconstruccion con entrada
figure; 
plot(XReconstructed0AI); %grafica reconstruccion
figure;
plot(entradaNorm); 


% figure; 
% mesh(XReconstructed0AI); %grafica reconstruccion
% figure;
% mesh(entradaNorm); 
n=100
% Generar datos sintéticos en el espacio latente
n_synthetic_samples = xSize*2;
%latent_space = randn(n_synthetic_samples, n); % Muestras aleatorias en el espacio latente
latent_space = rand(n_synthetic_samples, n).*randi(10,n_synthetic_samples,n); % Muestras aleatorias en el espacio latente

% Usar la red de decodificación del autoencoder para convertir al espacio original
synthetic_data_from_latente = predict(autoenc, latent_space)
synthetic_data = synthetic_data_from_latente;
figure;
reconstruccionData(entradaNorm,1,xSize,1);



figure;
reconstruccionData(synthetic_data,1,xSize,1);
figure;
reconstruccionData(synthetic_data,2,xSize,1);

figure;
reconstruccionDataAll(synthetic_data,xSize);
hold on;
plot(reconstruccionData(input,1,xSize,1),'*');
plot(reconstruccionData(input,2,xSize,1),'+');

testFiguras

synthetic_data = predict(autoenc, latent_space(:,1));
figure;
reconstruccionData(entradaNorm,1,xSize,1);

synthetic_data = predict(autoenc, latent_space(:,2));
figure;
reconstruccionData(entradaNorm,1,xSize,1);

% a) Generar datos para simulación de elución para avance y desarrollo matemático y experimental
% b) Luego de manera experimental:
%     - con datos de un experimento real - seleccionar curvas sinteticas cercanas (o la más cercana o auto) y cómputar "predecir" parámetros 
%         - red neuronal artificial como predictor de parámetros
%             - se conecta con la linea de investigación de "biocomputación: 
%                 - computación realizada a traves de reacciones químicas, difusión/dispersión moleculas, óptica, 
%                 tiempos de predicción "un tiempo de ciclo (tiempo de viaje por el medio) vs miles de tiempos de ciclos de CPU (arhc VON N. 'HZ')" 
%                 - innovación tecnológica: crear dispositivos "green ai-biotecnológicos" - que predigan "paramétros - indicadores de elución - etc." 
%                 pero incorporado al hardware de sensor, o bien otros tipos de "ínteres" de medición y predicción biotecnológica.
%         - uso: solo se óptimizaria una vez para un proceso de alto
%         computo que generará un modelo pre-entrenado de curvas de elusión? 
%     - con dichos datos de entrenamiento usarlo para: 
%                     - transferencia de capácidades (practica del machine learning)
%                     - construir modelos generalizados de elución para: predicción, optimización, simulación, etc"