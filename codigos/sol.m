%% Gráfico solucion
function yc=sol(x,t,factor_tpo,tinyeccion,c0,nz,tc)
%% Evaluación de la solución óptima en el tiempo experimental
%c=solver_rk_weno5_2025_df(tinyeccion,x,c0,nz,tc);
c=solver_rk2_2025(tinyeccion,x,c0,nz,tc);
%c=solver_rk_weno5_2025_df_strang(tinyeccion,x,c0,nz,tc);
% L=length(tc);
% dt=tc(2:L)-tc(1:L-1);
% c=solver_imex_weno5_2025_df(tinyeccion,x,c0,nz,tc,dt);
I=zeros(1,length(t));
for j=1:length(t)
    I(j)=find(tc==t(j));
end
yc = c(nz,I)';