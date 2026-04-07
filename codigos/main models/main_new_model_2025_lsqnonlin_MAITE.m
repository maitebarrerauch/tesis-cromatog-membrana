%% Llamada principal de programa
%% Carga de datos

%x0=x;%% Llamada principal de programa
%% Carga de datos
%close all
%profile on
%% Descomentar l�neas 6-17 para la primera ejecuci�n
clear
addpath('../modificables')
carga_datos_new_model_2025_df;
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
%x0=x;
%lb(1)=m0; ub(1)=m0;
%% Opciones para fminsearch
% options = optimset('Display','iter','MaxIter',100,'TolFun',1e-17,'TolX',1e-17,'MaxFunEvals',1000);
%[x,fval]=fminsearch(@(x)fobj(x,yIn,zIn,c0,c0m,xi,nz,cinf,tinyeccion,tlavado,telucion,t,Coi,PM,Cosal,Cfsal,K,factor_tpo,t_igrad,tfin),x0,options);
%load('progreso_optimizacion.mat', 'x', 'fval', 'residual', 'exitflag', 'output', 'lambda', 'jacobian');
%% Opciones para lsqnonlin
options = optimset('Algorithm','trust-region-reflective','Display','iter','MaxIter',100000,'TolFun',1e-17,'TolX',1e-17,'MaxFunEvals',100000);
%[x,fval]=lsqnonlin(@(x)fopt_2025(x,yIn,c0,nz,tinyeccion,t,tc),x0,lb,ub,options);
%load('resultado_min_loc_b11.mat', 'x_opt_b11');
tic
[x,fval,residual,exitflag,output,lambda,jacobian]=lsqnonlin(@(x)fopt_2025_escalar(x,yIn,c0,nz,tinyeccion,t,tc),x0,lb,ub,options);
resnorm=fval;


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