%% Gráfico solucion
function plot_sol(x,t,factor_tpo,tinyeccion,c0,nz,tc,yIn)
%% Evaluación de la solución óptima en el tiempo experimental
%c=solver_rk_weno5_2025_df(tinyeccion,x,c0,nz,tc);
c=solver_rk2_2025(tinyeccion,x,c0,nz,tc);
%c=solver_rk_weno5_2025_df_strang(tinyeccion,x,c0,nz,tc);
% L=length(tc);
% dt=tc(2:L)-tc(1:L-1);
% c=solver_imex_weno5_2025_df(tinyeccion,x,c0,nz,tc,dt);
I=zeros(1,length(t));
for k=1:length(t) 
    tmp = find(tc==t(k)); 
    if ~isempty(tmp) 
        I(k) = tmp(1); % Store the index if found 
    else 
        I(k) = NaN; % Assign NaN if not found 
    end % 
end
% for j=1:length(t)
%     I(j)=find(tc==t(j));
% end
yc = c(nz,I)';
clf
%figure
%% Si deseamos interpolar la sol siempre que t(1)>0
% if t(1)>0
%     t=[0; t];
%     inter=1;
% end
% if inter==1
%     ti=linspace(0,t(2),30);
%     ci=interp1([0 t(2)],[yc(1) yc(2)],ti,'cubic')';
% end
% yc=[ci; yc(3:end)];
% %ycf= cf(nz+1,I)';
% clf
% %hold on
% if inter==1
%     plot(factor_tpo*([ti'; t(3:end)]),yc,'Color','b');
% else
%     plot(factor_tpo*t,yc,'Color','b');
% end
%plot(factor_tpo*t,yc,'LineWidth',1.5,'LineStyle','--','Color','k');
plot(factor_tpo*t,yc,'Color','b');
hold on
tg=factor_tpo*t(1:5:end);
yIng=yIn(1:5:end);
plot(tg,yIng,'diamond','markersize',1.5,'markerfacecolor','r')
legend('Model', 'Data')
xlabel('$t$','FontSize',14,'Interpreter','Latex')
ylabel('$c(1,t)$ (dimensionless)','FontSize',14,'Interpreter','Latex')
ylim([(1-1e-6)*min(ylim) max(ylim)])
xlim([factor_tpo*t(1) factor_tpo*t(end)])
shg
%% Curva de ruptura
%plot(factor_tpo*t,yc,'LineWidth',1.5);
%profile off