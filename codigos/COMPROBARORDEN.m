function prueba
    T=1.0; %REVISAR LIBRO
    L=2; %REVUSAR
    Nx_lista=[10, 20, 40, 80, 160, 320]; %revisar
    errors_L1 = zeros(size(Nx_lista));
    errors_Linf = zeros(size(Nx_lista));
    
    for idx = 1:length(Nx_lista)
        Nx = Nx_lista(idx);
        dx = L / Nx;
        x = -1 : dx: 1-dx; %malla
        dt = 0.0001; %CFL
        Nt =ceil(T/dt); %round para que sea n entero de pasos ceil para cubrir hasta el ultimo T
        
        %cond inicial
        u0 = sin(pi * x)'; %lu weno espera vector columna
        u = u0;
        
        for n=1:Nt
            u =RK32(u, dt,dx);
        end
        
        u_exact = sin(pi*(x-T))';
        
        errors_L1(idx) = dx*sum(abs(u-u_exact));
        errors_Linf(idx) = norm(u-u_exact, inf);
    end
    
    fprintf('Nx\t L1 error\t L1 orden\t Linf error\t Linf orden\n');
    for idx = 1:length(Nx_lista)
        if idx==1
            fprintf('%3d\t%10.3e\t\t\t%10.3e\n',... 
                Nx_lista(idx), errors_L1(idx), errors_Linf(idx));
        else 
            order_L1 = log2(errors_L1(idx-1)/errors_L1(idx)); %revisar libro
            order_Linf = log2(errors_Linf(idx-1)/errors_Linf(idx));
            fprintf('%3d\t%10.3e\t%9.2f\t%10.3e\t%9.2f\n',...
                Nx_lista(idx), errors_L1(idx), order_L1, ...
                errors_Linf(idx), order_Linf);
        end
    end
end

    
        
        
        
        
        
        
        
