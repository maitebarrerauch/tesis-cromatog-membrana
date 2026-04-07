%% Resuelve la ecuación de c considerando un splitting en el tiempo en dos etapas:
%% advección y reacción (hemos despreciado la difusión)
% t: vector de tiempos experimentales
% tc: tiempo de cálculo para resolver el problema directo (tc contiene a t)
function sol=solver_rk2_2025(tinyeccion,x,c0,nz,tc)
L=length(tc);
dt=tc(2:L)-tc(1:L-1);
%nz=round(1/h);
h=1/nz;
c=zeros(2*nz,L);
c(:,1)=c0;
m=x(1);
n=x(2);
r=x(3);
%% Resolución de la ecuación de c
% Esta se divide en dos pasos (método tipo splitting) 
for k=1:L-1
    C=c(1:nz,k);
    cs=c(nz+1:2*nz,k);
    % * Primer paso de RK óptimo de orden 2 *
    Cfk=bc_2025(tc(k),tinyeccion);
    c1=C+dt(k)*LUz_weno5(C,5,Cfk,h);
    % Ec. cinética de cs (por ahora Langmuir, cambiar R para cambiar la cinética)
    R=reaction(x,c1,cs,1);
    cs1 = exp( -n*dt(k)/(m*(r-1)) )*cs-( m*(r-1)/n )*( exp( -n*dt(k)/(m*(r-1)) )-1 ).*R;
    % Parte reactiva para c
    R=reaction(x,c1,cs1,0);
    c1=exp(-n*dt(k))*c1-(1/n)*( exp(-n*dt(k)) - 1 ).*R;
    % * Segundo paso de RK óptimo de orden 2 *
    Cfk=bc_2025(tc(k)+dt(k),tinyeccion);
    c2=0.5*C+0.5*c1+0.5*dt(k)*LUz_weno5(c1,5,Cfk,h);
    % Ec. cinética de cs (por ahora Langmuir, cambiar R para cambiar la cinética)
    R=reaction(x,c2,cs1,1);
    cs2 = exp( -n*dt(k)/(m*(r-1)) )*cs1-( m*(r-1)/n )*( exp( -n*dt(k)/(m*(r-1)) )-1 ).*R;
    %cs2 = 0.5*cs+0.5*cs1+exp( -n*0.5*dt(k)/(m*(r-1)) )*cs1-( m*(r-1)/n )*( exp( -n*dt(k)/(m*(r-1)) )-1 ).*R;
    % Parte reactiva para c
    R=reaction(x,c2,cs2,0);
    c2=exp(-n*dt(k))*c2-(1/n)*( exp(-n*dt(k)) - 1 ).*R;
    %c2=0.5*C+0.5*c1+exp(-n*0.5*dt(k))*c2-(1/n)*( exp(-n*0.5*dt(k)) - 1 ).*R;
    % Actualización de las variables
    c(1:nz,k+1)=c2;
    c(nz+1:2*nz,k+1)=cs2;
end
sol=c;