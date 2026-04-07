close all
%profile on
%% Descomentar l�neas 6-17 para la primera ejecuci�n
clear
addpath('../modificables')
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
for i=11:11 % AGREGACION %size(X_1peak,2)=75
position=i  % AGREGACION
carga_datos_new_model_2025_df_Synteticos;  % AGREGACION
m0 = (1-Eb)*cinf/(Eb*Co); %valor original (definición)

n0 = cinf*xi;
r0 = 1 + Co; % Kd=1 al inicio
x0=[m0; n0; r0];
lb=zeros(size(x0))+1e-6;
lb(3)=1+1e-6;
ub=inf*ones(size(x0));

%% Opciones para patternsearch - Encuentre el mínimo de una función mediante la búsqueda de patrones
options =optimoptions('patternsearch','Display','iter','PlotFcn',@psplotbestf);
tic
[x,fval] = patternsearch(@(x)fopt_2025_escalar(x,yIn,c0,nz,tinyeccion,t,tc),...
    x0,[],[],[],[],lb,ub,[],options)
Xsalida = [Xsalida;x]
toc

plot_sol(x,t,factor_tpo,tinyeccion,c0,nz,tc,yIn)
end

% x =
% 
%     2.5187
%     1.9848
%     1.8750

%v = v(:);                  % asegurar que es columna
%M = reshape(v, 3, []).';   % ahora M es 76 x 3
