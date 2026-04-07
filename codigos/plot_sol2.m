function plot_sol(x,t,factor_tpo,tinyeccion,c0,nz,tc,yIn)

    c = solver_rk2_2025(tinyeccion,x,c0,nz,tc);
    [nz_loc, Nt_int] = size(c);

    if nz_loc ~= nz
        error('Dimensión espacial inconsistente en plot_sol');
    end

    if Nt_int == length(tc)
        % caso antiguo
        I = zeros(1,length(t));
        for k = 1:length(t)
            tmp = find(tc == t(k));
            if ~isempty(tmp)
                I(k) = tmp(1);
            else
                I(k) = NaN;
            end
        end
        yc = c(nz, I)';
    else
        % caso nuevo
        t_model = linspace(tc(1), tc(end), Nt_int);
        c_out   = c(nz,:);
        yc      = interp1(t_model, c_out, t, 'linear', 'extrap');
    end

    fprintf('max(modelo) = %.4g, max(datos) = %.4g\n', max(yc), max(yIn));

    figure;
    plot(t, yc, 'b-'); hold on;
    plot(t, yIn, 'r.');
    xlabel('t');
    ylabel('c(1,t) (dimensionless)');
    legend('Model','Data');
end
