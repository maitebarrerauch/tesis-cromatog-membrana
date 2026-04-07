function newData = rotateMatrix(data, shiftValue)
% generateTransformedData - Genera nuevos datos rotando o desplazando una matriz
%
% Sintaxis:
%   newData = generateTransformedData(data, method, shiftValue)
%
% Entradas:
%   data        - Matriz original (2D o 3D si son múltiples matrices)
%   method      - 'rotate' o 'shift' para el tipo de transformación
%   shiftValue  - Valor de desplazamiento (para 'shift'), en columnas
%
% Salida:
%   newData     - Matriz transformada

    if nargin < 3
        shiftValue = 1; % Desplazamiento por defecto
    end
    % Desplazamiento hacia la derecha circular
    newData = circshift(data, [0, shiftValue]);
end