%% Primer aplicar el optimizador
load('x_base11.mat');
C=[];

for i=1:5
    yc=sol(x,t,factor_tpo,tinyeccion,c0,nz,tc);
    C=[C yc];
    x(3)=1.5*x(3);
end


% Gráfico 1 a la izquierda
figure;
mesh(C);
colormap('jet');
title('Superficie de soluciones en función de r y tiempo');
xlabel('Valor de r');
ylabel('Tiempo');
zlabel('Concentración (C)');


% Gráfico 2 a la derecha
figure;
plot(factor_tpo*t, C);
title('Evolución temporal de la concentración para distintos r');
xlabel('Tiempo');
ylabel('Concentración (C)');
%title('Curvas C vs tiempo');

%figure(1);ylim([0,max(factor_tpo*t)]);
%figure(2);xlim([0,max(factor_tpo*t)]);