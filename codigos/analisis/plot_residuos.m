function plot_residuos(x,t,factor_tpo,tinyeccion,c0,nz,tc,yIn)

c = solver_rk2_2025(tinyeccion,x,c0,nz,tc);

I=zeros(1,length(t));
for k=1:length(t)
    tmp = find(tc==t(k));
    if ~isempty(tmp)
        I(k) = tmp(1);
    else
        I(k) = NaN;
    end
end

yc = c(nz,I)';

res = yIn - yc;

figure
plot(t,res,'LineWidth',1)
hold on
yline(0,'--')
hold off
title('Residuos del ajuste')
xlabel('Tiempo adimensional')
ylabel('Residuo (exp - modelo)')
grid on