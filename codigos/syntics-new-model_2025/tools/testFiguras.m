% Crear una figura
figure;

% Número de filas y columnas de la cuadrícula de subgráficos
numRows = 2; % 2 filas
numCols = 5; % 5 columnas
xGrupoSal = [];
xGrupoEl = [];
% Generar 10 subgráficos
for i = 1:10
    % Crear el subgráfico en la posición correspondiente
    subplot(numRows, numCols, i);
    i
    tmp = reconstruccionData(synthetic_data,i,xSize,1);
    xGrupoSal = [xGrupoSal,tmp(:,2)];
    xGrupoEl = [xGrupoEl,tmp(:,1)];
    % Agregar título para identificar cada subgráfico
    title(['Elusión ' num2str(i)]);
    
    % Reducir el tamaño de la fuente para no sobrecargar los gráficos pequeños
    set(gca, 'FontSize', 8);
end

% Ajustar el espaciado entre los subgráficos
sgtitle('Ejemplo de 10 elusiones sintéticas'); % Título general para la figura
figure
boxchart(xGrupoSal)