function [salida,t] = selectionCurves(C_tmp,t_tmp)
% Delete column with data nan
valores = any(isnan(C_tmp), 1)
C_tmp(:, valores) = [];  % Elimina columnas que contienen valores NaN
%t_tmp(:, valores) = [];
% Calculo de integral de vector
integralValue = trapz(C_tmp);  % Calcula la integral del vector C_tmp usando la regla del trapecio
% Obtener posiciones donde los valores cumplen ciertas reglas
% Ejemplo 1: mayores que 0.5 y que primer valor sea cercano a 0
%positions = find(integralValue > 0.5 & (C_tmp(1,:) < 0.01));
% Ejemplo 1: que integral sea mayor que el promedio de integrales
% Seleccion heuristica-matemática de curvas 
positions = find( (integralValue > mean(integralValue)) );
salida = C_tmp(:,positions);
t = t_tmp;

% Aplicar criterio de soporte compacto al interior del intervalo [1 and N]
% cercano a 0.
% aplicar peak - momento y tiempos de retención - 
%positions = find( salida(1,:) < 0.01);
%salida = salida(:,positions)

end