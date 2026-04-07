function [tau, Cout] = sim_out_given(m, n, r)
    % Requiere en el workspace: t, tc, nz, tinyeccion, c0
    % y el solver: solver_rk2_2025(tinyeccion,x,c0,nz,tc)

    x = [m; n; r];
    c = solver_rk2_2025(tinyeccion, x, c0, nz, tc);  % 2*nz x L

    % Tomamos la concentración libre a la salida (nodo nz) en los tiempos experimentales t
    I = zeros(1, length(t));
    for k = 1:length(t)
        I(k) = find(tc == t(k));
    end

    Cout = c(nz, I)';   % C_out(τ) adimensional
    tau  = t;           % ya está adimensional (τ = t·v/L en tu código)
end
