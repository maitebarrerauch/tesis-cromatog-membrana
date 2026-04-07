clear
addpath('../modificables')
%traza_optimos = 1;
%% Llamada principal de programa
%% Carga de datos
close all

carga_datos_new_model_2025_df;
m0 = (1-Eb)*cinf/(Eb*Co); %valor original (definición)
%m0=1.0e+03*9.1523;
%m0=1.0e+03*1.1523;

n0 = cinf*xi;
r0 = 1 + Co; % Kd=1 al inicio
x0=[m0; n0; r0];
lb=zeros(size(x0))+1e-6;
lb(3)=1+1e-6;
ub=inf*ones(size(x0));

%% Opciones para fminsearch - Encontrar el mínimo de una función multivariable no restringida utilizando el método sin derivadas
options = optimset('Display','iter','MaxIter',1000,'TolFun',1e-17,'TolX',1e-17,'MaxFunEvals',100000);
tic
[x,fval]=fminsearch(@(x)fopt_2025_escalar(x,yIn,c0,nz,tinyeccion,t,tc),x0,options);
toc

plot_sol(x,t,factor_tpo,tinyeccion,c0,nz,tc,yIn)

% x =
% 
%    1.0e+06 *
% 
%    -1.2575
%     0.0000
%     9.6114