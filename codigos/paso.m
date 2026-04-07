%% Devuelve un intervalo de tiempo con un paso máximo 10 veces menor que el
% dado por el experimento
function tp=paso(t)
L=length(t);
dt=t(2:L)-t(1:L-1);
dtm=max(dt);
tp=[];
%tp(1)=t(1);
for k=1:length(t)-1
    %para una malla espacial de nz=40 int.
    tp=[tp;(t(k):0.5*dtm/4:t(k+1)-0.5*dtm/4)'];
    %para nz=20:
    %tp=[tp;(t(k):dtm/4:t(k+1)-dtm/4)'];
end
tp=[tp;t(end)];
% %tp=t;
% L=length(tp);
% dt=tp(2:L)-tp(1:L-1);