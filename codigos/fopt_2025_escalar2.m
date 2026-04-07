function f = fopt_2025_escalar(x,yIn,c0,nz,tinyeccion,t,tc)
    % x es [m; n; r]

    c = solver_rk2_2025(tinyeccion,x,c0,nz,tc);
    [nz_loc, Nt_int] = size(c);

    % Seguridad: nz_loc debería ser = nz
    if nz_loc ~= nz
        error('Dimensión espacial inconsistente: nz = %d, filas(c) = %d', nz, nz_loc);
    end

    if Nt_int == length(tc)
        % CASO ANTIGUO: el solver devolvía nz x length(tc)
        I = zeros(1,length(t));
        for k = 1:length(t)
            tmp = find(tc == t(k));
            if ~isempty(tmp)
                I(k) = tmp(1);
            else
                I(k) = NaN;
            end
        end
        yc = c(nz, I)';      % como antes
    else
        % CASO NUEVO: el solver tiene muchos más pasos internos (54054)
        % asumimos que integra desde tc(1) hasta tc(end)
        t_model = linspace(tc(1), tc(end), Nt_int);  % tiempos internos del modelo
        c_out   = c(nz, :);                          % salida en z = 1
        yc      = interp1(t_model, c_out, t, 'linear', 'extrap');
    end

    % Error cuadrático ponderado por dt
    L  = length(t);
    dt = t(2:L) - t(1:L-1);
    res = yIn(2:end) - yc(2:end);

    f = sum( dt(:) .* (res(:).^2) );
end
