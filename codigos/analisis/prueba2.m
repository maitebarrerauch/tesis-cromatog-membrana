function prueba2
    T = 0.10; CFL = 0.4;
    Nlist = [40 80 160 320 640];
    err = zeros(numel(Nlist)-1,1);

    tinyeccion = -Inf;         % <-- borde apagado: Cf(t)=0
    x_pars = [1; 1; 2];        % (m, n, r) seguros (r>1)
    for k = 1:numel(Nlist)-1
        % ----- malla gruesa -----
        N  = Nlist(k);
        h  = 1/N;
        xg = (0:N-1)'/N;
        c0g = [sin(2*pi*xg); zeros(N,1)];
        dtg = CFL*h; Ng = ceil(T/dtg); dtg = T/Ng;
        tcg = linspace(0,T,Ng+1).';

        sol_g = solver_rk2_2025(tinyeccion, x_pars, c0g, N, tcg);
        cg_T  = sol_g(1:N,end);

        % ----- malla fina 2N -----
        Nf = 2*N; hf = 1/Nf;
        xf = (0:Nf-1)'/Nf;
        c0f = [sin(2*pi*xf); zeros(Nf,1)];
        dtf = CFL*hf; Ntf = ceil(T/dtf); dtf = T/Ntf;
        tcf = linspace(0,T,Ntf+1).';

        sol_f = solver_rk2_2025(tinyeccion, x_pars, c0f, Nf, tcf);
        cf_T  = sol_f(1:Nf,end);

        % ----- restricción 2N -> N (promedio de pares) -----
        cf_on_g = 0.5*(cf_T(1:2:end) + cf_T(2:2:end));

        % ----- error L∞ -----
        err(k) = norm(cg_T - cf_on_g, inf);
    end

    EOC = log2(err(1:end-1)./err(2:end));
    fprintf('N\t Err(Linf)\t EOC\n');
    for k = 1:numel(err)
        if k == 1
            fprintf('%d\t %.3e\t   -\n', Nlist(k+1), err(k));
        else
            fprintf('%d\t %.3e\t %.2f\n', Nlist(k+1), err(k), EOC(k-1));
        end
    end
end
