%Esta funci�n entrega, para cada prote�na: 
%Ep: Porosidad de la part�cula por el componente,
%PM: Peso Molecular del componente,
%K: Factor de correlaci�n cantidad:concentraci�n de prote�na(mg/(mAU*mL))

function [N,Ep,K,PM]=prop_proteinasB(BSA,Hb)

%global N Ep K PM

N    = BSA+Hb;                 % N�mero de prote�nas. La sal es el componente N+1
Ep    = ones(1,N);     
K     = ones(1,N);         
PM    = ones(1,N);

i   = 1;
if (BSA==1)
    Ep(i)   = 0.55; % ya no es necesario
    K(i)    = 0.0012;           % mg/(mAU*mL)
    PM(i)   = 14300;
    i       = i+1;
end
if (Hb==1)
        Ep(i)   = 0.58;
        K(i)    = 0.0052;    % mg/(mAU*mL) para UV 280nm
        PM(i)   = 64500;
end