%% Extiende la función definida en el arreglo X en la dirección z
% La extensión es en ambas direcciones
% s corresponde al orden de la extrapolación en el borde
% C es el valor de la condición de borde Dirichlet en la entrada de la col.
function X=extension_2025(X,s,C)
m=length(X);
X(1)=C;
XexAb=zeros(s,1);
XexAr=zeros(s,1);
for k=1:s
    XexAb(k)=( (-1)^(k+1)*fact(s)/(fact(k)*fact(s-k)) )*X(k);
    XexAr(k)=( (-1)^(k+1)*fact(s)/(fact(k)*fact(s-k)) )*X(m+1-k);
end
X=[sum(XexAb); X; sum(XexAr)];