%% Modulo de carga de datos
%close all; %clc;
%tic
base_datos=2;
%% Datos experimentales
[datos, BSA, Hb, t_fin]=datos_new_model(base_datos); %Datos target y de experimento
%% Propiedades de las prote�nas (K y PM)
[N,Ep,K,PM]=prop_proteinasB(BSA,Hb); %Propiedades de proteinas

%% Par�metros fijos del problema
parameters_new_model_2025;
%parameters_new_model_Oscar;
%% Modelo de interpolacion Spline para comparar resultados a posteriori
%datos_interp = interp1(datos(:,2),datos(:,1),'pchip');
datos_interp=datos(:,2);
yIn = K*datos_interp/Co;
%zIn = datos(:,3);
%% Tiempo donde calcularemos la soluci�n del sistema (tiempo de muestreo)
t   = datos(:,1)./factor_tpo;
%% Par�metros num�ricos
% N�mero de intervalos en la direcci�n de la columna (z)
nz=40;
%nz=80;
%nz=100;
%nz=60;
% Paso espacial
%h=1/nz;
% Paso temporal
tc=paso_2025(t,1/nz);
%tc=paso(t);
% clf
% plot(factor_tpo*t,K*datos(:,2)/Co,'rdiamond','markersize',1.5,'markerfacecolor','r')
% shg
%pause(15)
%% Condicion inicial
% Para la prote�na
c0=zeros(2*(nz+1),1);
% Para el modulador
%c0m=(Cosal/Cfsal)*ones(nz+1,1);