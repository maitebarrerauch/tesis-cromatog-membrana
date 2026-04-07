%% Resuelve la ecuaci�n de cb considerando un splitting en el tiempo en dos etapas: advecci�n y reacci�n (hemos despreciado la difusi�n)
% t: vector de tiempos experimentales, donde tambi�n se resuelven las
% ecuaciones diferenciales con condiciones iniciales c0 y c0m
% id=1 resuelde la ecuaci�n de la prote�na (la guarda en la variable c)
% id=0 resuelve la ecuaci�n del modulador (la guarda en la variable cm)
function sol=solver_rk_weno5_2025(t,tinyeccion,x,c0,h,tc)
tc=paso(t);
L=length(tc);
dt=tc(2:L)-tc(1:L-1);
nz=round(1/h);
c=zeros(2*nz+2,L);
c(:,1)=c0;
m=x(1);
n=x(2);
r=x(3);
%% Resoluci�n de la ecuaci�n de c
% Esta se divide en dos pasos (m�todo tipo splitting) 
for k=1:L-1
    C=c(1:nz+1,k);
    cs=c(nz+2:2*nz+2,k);
    % * Primer paso de RK �ptimo de orden 3 *
    Cfk=bc_2025(tc(k),tinyeccion);
    c1=C+dt(k)*LUz_weno5(C,5,Cfk,h);
    % Ec. cin�tica de cs (por ahora Langmuir, cambiar R para cambiar la cin�tica)
    R=reaction(x,c1,cs,1);
    cs1 = exp( -n*dt(k)/(m*(r-1)) )*cs-( m*(r-1)/n )*( exp( -n*dt(k)/(m*(r-1)) )-1 ).*R;
    % Parte reactiva para c
    R=reaction(x,c1,cs1,0);
    c1=exp(-n*dt(k))*c1-(1/n)*( exp(-n*dt(k)) - 1 ).*R;
    % * Segundo paso de RK �ptimo de orden 3 *
    Cfk=bc_2025(tc(k)+dt(k)/2,tinyeccion);
    c2=0.75*C+0.25*c1+0.25*dt(k)*LUz_weno5(c1,5,Cfk,h);
    % Ec. cin�tica de cs (por ahora Langmuir, cambiar R para cambiar la cin�tica)
    R=reaction(x,c2,cs1,1);
    cs2 = exp( -n*dt(k)/(m*(r-1)) )*cs1-( m*(r-1)/n )*( exp( -n*dt(k)/(m*(r-1)) )-1 ).*R;
    % Parte reactiva para c
    R=reaction(x,c2,cs2,0);
    c2=exp(-n*dt(k))*c2-(1/n)*( exp(-n*dt(k)) - 1 ).*R;
    % * Tercer paso de RK �ptimo de orden 3 *
    Cfk=bc_2025(tc(k)+dt(k),tinyeccion);
    c3=(1/3)*C+(2/3)*c2+(2/3)*dt(k)*LUz_weno5(c2,5,Cfk,h);
    % Ec. cin�tica de cs (por ahora Langmuir, cambiar R para cambiar la cin�tica)
    R=reaction(x,c3,cs2,1);
    cs3 = exp( -n*dt(k)/(m*(r-1)) )*cs2-( m*(r-1)/n )*( exp( -n*dt(k)/(m*(r-1)) )-1 ).*R;
    % Parte reactiva para c
    R=reaction(x,c2,cs3,0);
    c3=exp(-n*dt(k))*c3-(1/n)*( exp(-n*dt(k)) - 1 ).*R;
    % Actualizaci�n de las variables
    c(1:nz+1,k+1)=c3;
    c(nz+2:2*nz+2,k+1)=cs3;
end
sol=c;