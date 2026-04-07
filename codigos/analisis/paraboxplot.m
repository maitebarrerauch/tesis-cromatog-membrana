% Separar las columnas
m_est = Xsalida(:,1);
n_est = Xsalida(:,2);
r_est = Xsalida(:,3);

% Intervalos de confianza 
IC_m = prctile(m_est, [2.5 97.5]);
IC_n = prctile(n_est, [2.5 97.5]);
IC_r = prctile(r_est, [2.5 97.5]);

% Comparar con los parámetrosreales
m_real = x(1);
n_real = x(2);
r_real = x(3);

en_IC_m = (m_real >= IC_m(1)) && (m_real <= IC_m(2));
en_IC_n = (n_real >= IC_n(1)) && (n_real <= IC_n(2));
en_IC_r = (r_real >= IC_r(1)) && (r_real <= IC_r(2));

fprintf('IC m: [%g, %g], real = %g, dentro? %d\n', IC_m(1), IC_m(2), m_real, en_IC_m);
fprintf('IC n: [%g, %g], real = %g, dentro? %d\n', IC_n(1), IC_n(2), n_real, en_IC_n);
fprintf('IC r: [%g, %g], real = %g, dentro? %d\n', IC_r(1), IC_r(2), r_real, en_IC_r);


 % Xsalida: 76 x 3, solo sintéticos
% m_real, n_real, r_real: parámetros reales

figure;
boxplot(Xsalida, 'Labels', {'m','n','r'});
ylabel('Valor del parámetro');
title('Distribución de parámetros sintéticos vs real');
grid on;
hold on;

hReal = plot(1:3, x, 'r*', 'MarkerSize', 10, 'LineWidth', 1.5);

% Si solo quieres etiquetar el real:
legend(hReal, {'Valor real'}, 'Location', 'best');

hold off;

% %con base de datos 11:
% IC m: [0.127323, 0.127323], real = 262144, dentro? 0
% IC n: [3.21489e-05, 3.79901e-05], real = 524288, dentro? 0
% IC r: [1.0167, 3], real = 2.74878e+11, dentro? 0
%con base 2 funciona

figure;

% --- Fondo blanco real ---
set(gcf, 'Color', 'white', 'InvertHardcopy', 'off');

ax = axes('Color','white');
hold(ax,'on');

% --- Generar boxplot (base) ---
h = boxplot(Xsalida, 'Labels', {'m','n','r'});

% % segud grafico
% 
% % 1. Forzar todas las líneas a negro
% allLines = findall(gca, 'Type', 'Line');
% set(allLines, 'Color', 'black', 'LineWidth', 2.3);
% 
% % 2. Fuerza extra a la mediana (más gruesa)
% med = findobj(gca,'Tag','Median');
% set(med, 'Color', 'black', 'LineWidth', 3);
% 
% % 3. Fuerza la caja (bordes) a grosor extra
% boxes = findobj(gca,'Tag','Box');
% set(boxes, 'Color', 'black', 'LineWidth', 2.5);
% 
% % 4. Whiskers más negros y visibles
% whisk = findobj(gca,'Tag','Whisker');
% set(whisk, 'Color', 'black', 'LineWidth', 2.3);
% 
% % 5. Outliers negros y más fuertes
% out = findobj(gca,'Tag','Outliers');
% set(out, 'MarkerEdgeColor', 'black', 'LineWidth', 1.8);
% 
% % =====================================================
% 
% ylabel('Valor del parámetro');
% title('Distribución de parámetros sintéticos vs real');
% grid on;
% 
% % --- Parámetro real destacado ---
% plot(1:3, x, 'r*', 'MarkerSize', 14, 'LineWidth', 2.5);
% legend({'Valor real'}, 'Location','northwest');
% 
% % --- Ejes en negro ---
% set(gca,'XColor','black','YColor','black','LineWidth',1.8,'FontSize',12);
% 
% hold off;
% AG
% IC m: [9.36986, 20], real = 19.9578, dentro? 1
% IC n: [4.0704, 20], real = 20, dentro? 1
% IC r: [1.23366, 4.41679], real = 4.88291, dentro? 0

% %PS
% IC m: [0.127323, 0.127323], real = 262144, dentro? 0
% IC n: [3.21489e-05, 3.7704e-05], real = 524288, dentro? 0
% IC r: [2, 3], real = 2.74878e+11, dentro? 0
