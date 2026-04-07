function [pcheaps,normpcheaps,tN] = normaliza_curva(datos,tiempo, N)
    % normaliza_curva Normaliza la curva de datos y genera un nuevo conjunto de N puntos.
    % 
    % Inputs:
    %   datos - Vector de datos a normalizar.
    %   N - Número de puntos en el nuevo conjunto.
    %
    % Outputs:
    %   pcheaps - Vector de N puntos normalizados.

    % Normalizar los datos - "LOCAL"  obs --> local != global
    datos_normalizados = (datos - min(datos)) ./ (max(datos) - min(datos));
    % Generar nuevos puntos
    x_original = linspace(1, length(datos_normalizados), length(datos_normalizados));
    x_nuevo = linspace(1, length(datos_normalizados), N);
    % Interpolación para obtener los nuevos puntos
    normpcheaps = interp1(x_original, datos_normalizados, x_nuevo, 'pchip'); 
    pcheaps = interp1(x_original, datos, x_nuevo, 'pchip');


    % Normalizar los datos - "LOCAL"  obs --> local != global
    %datos_normalizados = (tiempo - min(tiempo)) ./ (max(tiempo) - min(tiempo));
    % Generar nuevos puntos
    x_original = linspace(1, length(tiempo), length(tiempo));
    x_nuevo = linspace(1, length(tiempo), N);
    % Interpolación para obtener los nuevos puntos
    tN = interp1(x_original, tiempo, x_nuevo, 'pchip'); 
    

    if size(normpcheaps,1) == 1
        normpcheaps=normpcheaps';
        pcheaps=pcheaps';

    end
    
end