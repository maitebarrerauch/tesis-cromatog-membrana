%% ================================
% Validación rápida usando solo IC de parámetros
%% ================================

% Xsaida: matriz de 83 x 3
% columnas: [m n r]
% x: vector óptimo obtenido con lsqnonlin para la curva real

% Percentiles 95%
IC_m = prctile(Xsalida(:,1), [2.5 97.5]);
IC_n = prctile(Xsalida(:,2), [2.5 97.5]);
IC_r = prctile(Xsalida(:,3), [2.5 97.5]);

% Valor óptimo real
m_opt = x(1);
n_opt = x(2);
r_opt = x(3);

% Verificación
m_inside = (m_opt >= IC_m(1)) && (m_opt <= IC_m(2));
n_inside = (n_opt >= IC_n(1)) && (n_opt <= IC_n(2));
r_inside = (r_opt >= IC_r(1)) && (r_opt <= IC_r(2));

fprintf('m_opt = %.6e, IC95%% = [%.6e, %.6e] -> %d\n', m_opt, IC_m(1), IC_m(2), m_inside);
fprintf('n_opt = %.6e, IC95%% = [%.6e, %.6e] -> %d\n', n_opt, IC_n(1), IC_n(2), n_inside);
fprintf('r_opt = %.6e, IC95%% = [%.6e, %.6e] -> %d\n', r_opt, IC_r(1), IC_r(2), r_inside);

% Resumen global
inside_all = m_inside && n_inside && r_inside;

if inside_all
    fprintf('\nEl vector óptimo x de la curva real cae completamente dentro de los IC95%%.\n');
else
    fprintf('\nEl vector óptimo x de la curva real NO cae completamente dentro de los IC95%%.\n');
end