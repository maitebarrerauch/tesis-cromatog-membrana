
%% Gráfico solucion
c=solver_rk_weno5_2025(t,tinyeccion,x,c0,h,tc);
%% Evaluación de la solución óptima en el tiempo de muestreo
I=zeros(1,length(t));
tc=paso(t);
for j=1:length(t)
    I(j)=find(tc==t(j));
end
yc = c(nz+1,I)';
%clf
figure
plot(factor_tpo*t,yc,'LineWidth',1.5);
hold on
plot(factor_tpo*t,yIn,'diamond','markersize',1.5,'markerfacecolor','r')
legend('Model','Data','Fontsize',14)
xlabel('$t$','FontSize',14,'Interpreter','Latex')
ylabel('$c(1,t)$ (dimensionless)','FontSize',14,'Interpreter','Latex')
ylim([min(ylim)/10 max(ylim)])
xlim([factor_tpo*t(1) factor_tpo*t(end)])
shg
%profile off