function yc = obtener_concentracion_salida(tinyeccion, x, c0, nz, tc, t)
    % Resuelve el sistema y devuelve la concentración de salida
    c = solver_rk_weno5_2025_df(tinyeccion, x, c0, nz, tc);
    
    % Encuentra los índices correspondientes a los tiempos t
    I = zeros(1, length(t));
    for k = 1:length(t)
        I(k) = find(tc == t(k));
    end
    
    % Extrae la concentración de salida (último punto espacial)
    yc = c(nz, I)';
end