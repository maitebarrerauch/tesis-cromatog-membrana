close all
%% 7. Generar nuevos datos sintéticos
% numNewSamples = 100;
ZNew = randn(latentDim, numNewSamples, 'single');  % muestreo del espacio latente
XNew = predict(decoderNet, dlarray(ZNew, "CB"));
XNew = extractdata(XNew);

% Reshape a formato original
syntheticData = reshape(XNew', [numNewSamples, dataSize(1), dataSize(2)]);


disp("Datos sintéticos generados con éxito.");
GG = gather(syntheticData);
ventana_general_vae = 15
% M = movmean(GG',ventana_general_vae).*maxVal;
% 
% %GGI = diff(M);
% GGI = M;
% figure;
% mesh(sortrows(GGI',1))
%% 8. Visualizar ejemplo
figure;
dataPOS = 1;
salidaData = [];
%for i = 1:4
%    subplot(2,2,i);
    data_out = syntheticData(:,:,:).*maxVal;
    salidaData = [salidaData,gather(data_out)']
    mesh(data_out);
    title("Matriz sintética #" + i);
    colorbar;
%end
M = movmean(salidaData,ventana_general_vae)
figure;    mesh(M');

plot(salidaData,'DisplayName','salidaData')
figure;plot(M,'DisplayName','salidaData')
figure;pcolor(X_train(:,:));
figure;pcolor(M(:,:));
% figure;
% for i = 1:4
%     subplot(2,2,i);
%     data_out = syntheticData(:,:,i).*maxVal
%     mesh(diff(data_out));
%     title("Matriz sintética #" + i);
%     colorbar;
% end
% 
% figure;
% for i = 1:4
%     subplot(2,2,i);
%     data_out = syntheticData(:,:,i).*maxVal
%     mesh(diff(data_out'));
%     title("Matriz sintética #" + i);
%     colorbar;
% end

%figure;mesh(diff(data'));