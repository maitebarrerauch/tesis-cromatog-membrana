function f=fopt_2025_escalar(x,yIn,c0,nz,tinyeccion,t,tc)
% x es un vector de largo 3 con coordenadas: m, n, r
% BSA=1 y HB=0 si se simula la curva para la BSA, HB=1 y BSA=0 si se simula la hemoglobina. 
%c=solver_rk_weno5_2025_df(tinyeccion,x,c0,nz,tc);
%% Nuevo método: TVD-RK2
c=solver_rk2_2025(tinyeccion,x,c0,nz,tc);
%% Strang splitting
%c=solver_rk_weno5_2025_df_strang(tinyeccion,x,c0,nz,tc);
% L=length(tc);
% dt=tc(2:L)-tc(1:L-1);
%c=solver_imex_weno5_2025_df(tinyeccion,x,c0,nz,tc,dt);
% Evaluamos la solución en los tiempos experimentales (t)
I=zeros(1,length(t));
for k=1:length(t)
    tmp = find(tc==t(k));
    if ~isempty(tmp)
        I(k) = tmp(1); % Store the index if found
    else
        I(k) = NaN; % Assign NaN if not found
    end
   % I(k)=find(tc==t(k));
end
% for k=1:length(t)
%     I(k)=find(tc==t(k));
% end
%nz=round(1/h);
%% Modificación para el modelo nuevo
yc = c(nz,I)';
% ym = Cfsal*cm(nz+1,I)';
%% * Funcion de error para lsqnonlin *
% Norma L2 al cuadrado (funciona mejor)
L=length(t);
dt=t(2:L)-t(1:L-1);
f = sqrt(dt).*( yIn(2:end)-yc(2:end) );%./( sqrt(dt).*yIn(2:end)+ 1e-6);
%f=1e-6*f./( sqrt(dt).*yIn(2:end)+1e-4 );
%f=( c(nz+1,I(2:end))-0.9*c(nz,I(2:end)) );%./( sqrt(dt).*0.9*c(nz,I(2:end))+1e-4 );
%
% Distancia entre los datos y el modelo al cuadrado
%f = yIn-yc;
%% * Funcion de error para fminsearch y AG *
f=norm(f)^2;