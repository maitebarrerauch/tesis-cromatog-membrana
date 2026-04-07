%% Modulo de carga de datos
%close all; %clc;
%tic
base_datos=2;
%% Datos experimentales
[datos, BSA, Hb, t_fin, isSynthetic]=datos_new_model(base_datos); %Datos target y de experimento
%% Propiedades de las prote�nas (K y PM)
[N,Ep,K,PM]=prop_proteinasB(BSA,Hb); %Propiedades de proteinas

%% Par�metros fijos del problema
parameters_new_model_2025;

escala = 1000;         
ventana = 5;  
%parameters_new_model_Oscar;
%% Modelo de interpolacion Spline para comparar resultados a posteriori
%datos_interp = interp1(datos(:,2),datos(:,1),'pchip');
% 
% 
% if isSynthetic
%     factor_tpo = 1;
%     t          = datos(:,1);
%     datos_raw  = datos(:,2);              % ya adimensional / sintético
%     datos_interp = datos_raw;             % sin escalar ni suavizar
%     yIn        = datos_interp;
% else
%     datos_raw   = datos(:,2);                   % datos originales
%     datos_esc   = escala * datos_raw;           % escala: datos(:,2)*1000
%     datos_suav  = movmean(datos_esc, ventana);  % suavizado con movmean
% 
%     datos_interp = datos_suav;                  
%     % tiempo adimensional y concentración adimensional (pero ya escalada y suavizada)
%     t   = datos(:,1) ./ factor_tpo;
%     yIn = K * datos_interp / Co;
% end
datos_interp=datos(:,2);
if isSynthetic
    factor_tpo = 1;                                    % ← CLAVE: no reescales el tiempo sintético
    t   = datos(:,1);
    yIn = datos_interp;                                   % ya adimensional
else
    t   = datos(:,1) ./ factor_tpo;
    yIn = K*datos_interp/Co;                              % adimensionalizar datos reales
end

yIn = K*datos_interp/Co; %este lo comente
%zIn = datos(:,3);
%% Tiempo donde calcularemos la soluci�n del sistema (tiempo de muestreo)
%t   = datos(:,1)./factor_tpo;
%% Par�metros num�ricos
% N�mero de intervalos en la direcci�n de la columna (z)
nz=40;
%nz=80;
%nz=100;
%nz=60;
% Paso espacial
%h=1/nz;
% Paso temporal
dz=1/nz;
tc=paso_2025(t,dz);
%tc=paso(t);
% clf
% plot(factor_tpo*t,K*datos(:,2)/Co,'rdiamond','markersize',1.5,'markerfacecolor','r')
% shg
%pause(15)
%% Condicion inicial
% Para la prote�na
c0=zeros(2*nz,1);
% Para el modulador
%c0m=(Cosal/Cfsal)*ones(nz+1,1);