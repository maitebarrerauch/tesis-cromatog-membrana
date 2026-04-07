%% Devuelve un intervalo de tiempo con un paso máximo 10 veces menor que el
% dado por el experimento
function tp=paso_2025(t,h)
if t(1)>0
    t=[0; t];
end
L=length(t);
tp=[];
%nz=round(1/h);
%tp=zeros(L*(nz+1),1);
for k=1:L-1
    taux=(t(k):0.9*h:t(k+1))';
    tp=[tp; taux];
    %tp( (k-1)*(nz+1)+1:k*(nz+1) ) = ( t(k):h:t(k+1) )';
end
if tp(end)<t(end)
    tp=[tp;t(end)];
end