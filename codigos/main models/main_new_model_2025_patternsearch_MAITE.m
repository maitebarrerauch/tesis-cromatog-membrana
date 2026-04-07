clear
%traza_optimos = 1;
%% Llamada principal de programa
%% Carga de datos
close all
addpath('../modificables')
carga_datos_new_model_2025_df;
m0 = (1-Eb)*cinf/(Eb*Co); %valor original (definición)

n0 = cinf*xi;
r0 = 1 + Co; % Kd=1 al inicio
x0=[m0; n0; r0];                    
lb=zeros(size(x0))+1e-6;
lb(3)=1+1e-6;
ub=inf*ones(size(x0));

% scale = 1e3; % puedes ajustar
% lb = [1e-6; 1e-6; 1+1e-6];        % como ya tenías
% ub = [m0*scale; n0*scale; r0*scale]; % evita inf

%% Opciones para patternsearch - Encuentre el mínimo de una función mediante la búsqueda de patrones
%options =optimoptions('patternsearch','Display','iter','PlotFcn',@psplotbestf);
options = optimoptions('patternsearch', ...
 'Display','iter','MaxIterations',1000,'MeshTolerance',1e-6, ...
'StepTolerance',1e-8,'UseCompletePoll',true);
    % 
    % 

tic
[x,fval] = patternsearch(@(x)fopt_2025_escalar(x,yIn,c0,nz,tinyeccion,t,tc),x0,[],[],[],[],lb,ub,[],options)
toc

plot_sol(x,t,factor_tpo,tinyeccion,c0,nz,tc,yIn)

