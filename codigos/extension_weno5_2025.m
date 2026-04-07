%% Extiende la función definida en el arreglo X en la dirección z
% La extensión es en un sólo sentido (hacia abajo o hacia arriba)
% s corresponde al orden de la extrapolación en el borde
% fg_dir=0: extrapolación hacia abajo, fg_dir=1: hacia arriba
% C es el valor de la condición de borde Dirichlet en la entrada de la col.
function X=extension_weno5_2025(X,s,fg_dir,C)
XexAr=zeros(s,1);
XexAb=zeros(s,1);
m=length(X);
if fg_dir==1
    for k=1:s
        XexAr(k)=( (-1)^(k+1)*fact(s)/(fact(k)*fact(s-k)) )*X(m+1-k);
    end
    X=[X; sum(XexAr)];
else
    X(1)=C;
    for k=1:s
        XexAb(k)=( (-1)^(k+1)*fact(s)/(fact(k)*fact(s-k)) )*X(k);
    end
    X=[sum(XexAb); X];
end