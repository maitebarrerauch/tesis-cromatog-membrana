function M = metrics_from_curve(tau, Cout)
    % Tiempo de breakthrough al 50% (C = 0.5)
    tb = NaN;
    idx = find(Cout >= 0.5, 1, 'first');
    if ~isempty(idx)
        if idx == 1
            tb = tau(1);
        else
            % interpolación lineal simple
            t1=tau(idx-1); t2=tau(idx);
            c1=Cout(idx-1); c2=Cout(idx);
            tb = t1 + (0.5 - c1)*(t2 - t1)/(c2 - c1);
        end
    end

    % Área bajo la curva (AUC) con trapecios
    auc = trapz(tau, Cout);

    % Promedio simple de la salida (en la ventana simulada)
    cmean = mean(Cout);

    M = struct('tb50', tb, 'auc', auc, 'cmean', cmean);
end
