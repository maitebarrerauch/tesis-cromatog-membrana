%% Llamada principal de programa
%% Carga de datos
close all
addpath('../modificables')
%profile on
%% Descomentar l�neas 6-17 para la primera ejecuci�n
clear
%profile on
%% Descomentar líneas 6-16 para la primera ejecución
Xsalida = [];
% NO reinicialices a ciegas Xsalida = [];
% % 
% if exist(['Xsalida_75_b2.mat'],'file')
%     % Ya hiciste antes las primeras curvas y las guardaste
%     load('Xsalida_75_b2.mat');   % carga Xsalida
% else
%     % Primera vez que corres
%     Xsalida = [];
% end

%global X_Synt tNb11 % AGREGACION
for i=1:1 % AGREGACION %size(X_1peak,2)=75
position=i  % AGREGACION
carga_datos_new_model_2025_df_Synteticos;  % AGREGACION
m0 = (1-Eb)*cinf/(Eb*Co); %valor original por definici�n
% m0=1.0e+03*9.1523; % Valor �ptimo (que se fija), versi�n inicial
% m0=5.101159119387620e+04; % valor �ptimo, con paso modificado (nz=80)
% m0=1.549738588485141e+04; % valor �ptimo c/20 iters. lys_ph5_abs (nz=80)
n0 = cinf*xi;
r0 = 1 + Co; % Kd=1 al inicio
x0=[m0; n0; r0];
lb=zeros(size(x0))+1e-6;
lb(3)=1+1e-6;
ub=inf*ones(size(x0));
%
%x0=x;%% Llamada principal de programa
%% Carga de datos
%close all
%profile on
%% Descomentar l�neas 6-17 para la primera ejecuci�n
% clear
% carga_datos_new_model_2025_df;
% m0 = (1-Eb)*cinf/(Eb*Co); %valor original por definici�n
% % m0=1.0e+03*9.1523; % Valor �ptimo (que se fija), versi�n inicial
% % m0=5.101159119387620e+04; % valor �ptimo, con paso modificado (nz=80)
% % m0=1.549738588485141e+04; % valor �ptimo c/20 iters. lys_ph5_abs (nz=80)
% n0 = cinf*xi;
% r0 = 1 + Co; % Kd=1 al inicio
% x0=[m0; n0; r0];
% lb=zeros(size(x0))+1e-6;
% lb(3)=1+1e-6;
% ub=inf*ones(size(x0));
%
%x0=x;
%lb(1)=m0; ub(1)=m0;
%% Opciones para fminsearch
% options = optimset('Display','iter','MaxIter',100,'TolFun',1e-17,'TolX',1e-17,'MaxFunEvals',1000);
%[x,fval]=fminsearch(@(x)fobj(x,yIn,zIn,c0,c0m,xi,nz,cinf,tinyeccion,tlavado,telucion,t,Coi,PM,Cosal,Cfsal,K,factor_tpo,t_igrad,tfin),x0,options);
%load('progreso_optimizacion.mat', 'x', 'fval', 'residual', 'exitflag', 'output', 'lambda', 'jacobian');
%% Opciones para lsqnonlin
options = optimset('Algorithm','trust-region-reflective','Display','iter','MaxIter',1000,'TolFun',1e-17,'TolX',1e-17,'MaxFunEvals',100000);
%[x,fval]=lsqnonlin(@(x)fopt_2025(x,yIn,c0,nz,tinyeccion,t,tc),x0,lb,ub,options);
%load('resultado_min_loc_b11.mat', 'x_opt_b11');
tic
[x,fval,residual,exitflag,output,lambda,jacobian]=lsqnonlin(@(x)double(fopt_2025_escalar(x,yIn,c0,nz,tinyeccion,t,tc)),x0,lb,ub,options);
resnorm=fval;
Xsalida=[Xsalida;x]
elapsed_sec=toc;
% save('progreso_optimizacion.mat', 'x', 'fval', 'residual', 'exitflag', 'output', 'lambda', 'jacobian');
%% Gr�fico solucion
%c=solver_rk_weno5_2025(tinyeccion,x,c0,nz,tc);
%% Nuevo m�todo: RK2
%c=solver_rk2_2025(tinyeccion,x,c0,nz,tc);
%plot_sol(x,t,factor_tpo,tinyeccion,c0,nz,tc,yIn)

%lb(1)=m0; ub(1)=m0;

%% Gr�fico solucion
%c=solver_rk_weno5_2025(tinyeccion,x,c0,nz,tc);
%% Nuevo m�todo: RK2
%c=solver_rk2_2025(tinyeccion,x,c0,nz,tc);
plot_sol(x,t,factor_tpo,tinyeccion,c0,nz,tc,yIn)
%save('progreso_optimizacion_b2_280.mat', 'x', 'fval', 'residual', 'exitflag', 'output', 'lambda', 'jacobian');
%info 
%corri la 15100 ahora

end
% ym = Cfsal*cm(nz+1,I)';
%% * Funcion de error para lsqnonlin *
% Norma L2 al cuadrado (funciona mejor)
L=length(t);
dt=t(2:L)-t(1:L-1);
%err = sqrt(dt).*( yIn(2:end)-yc(2:end) ); %residuos, norma l2

% Sum of Squared Errors
%SSE = norm(err)^2;
%SSE es fval
% Root Mean Squared Error
RMSE = sqrt((sum(residual.^2))./(L-4));

% Mean Absolute Error
MAE = sum(abs(residual)./(L-4));

% Mean Relative Error
MRE = mean(abs(residual ./ (yIn(2:end).*dt+1e-6)));
%MRE =norm(residual) ./ sqrt(sum((yIn(2:end)+1e-6).^2.*dt ))
MRE =sqrt(norm(residual.^2)) ./ sqrt(sum((yIn(2:end)+1e-6).^2.*dt ));
% Máximo error relativo
MaxRE = max(abs(residual ./ (yIn(2:end).*sqrt(dt)+1e-6)));
%MaxRE = max(abs(residual ./ (yIn(2:end)+1e-6)));

% % Error absoluto medio (MAPE)
MAPE =sum(abs(residual ./ (yIn(2:end).*sqrt(dt)+1e-6)))./(L-4);

% Coeficiente de determinación R²
%SST = sum((yIn - mean(yIn)).^2);
R2 = 1 - resnorm/(var(yIn(2:end) .* sqrt(dt))*(length(yIn)-2));


%% USANDO ERROR VECTOR
% x =
% 
%    41.0760
%     1.5479
%     1.0306

%% USANDO ERROR ESCALAR
% x =
% 
%     1.9669
%     1.9101
%     2.2929