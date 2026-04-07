%clear
%traza_optimos = 1;
%% Llamada principal de programa
%% Carga de datos
close all
%profile on

addpath('../modificables')
%% Descomentar líneas 6-16 para la primera ejecución
Xsalida = [];
% NO reinicialices a ciegas Xsalida = [];
% % 
% if exist(['Xsalida_vf_b11_primeras72.mat'],'file')
%     % Ya hiciste antes las primeras curvas y las guardaste
%     load('Xsalida_vf_b11_primeras72.mat');   % carga Xsalida
% else
%     % Primera vez que corres
%     Xsalida = [];
% end

%global X_Synt tNb11 % AGREGACION
for i=1:20 % AGREGACION
position=i  % AGREGACION
carga_datos_new_model_2025_df_Synteticos;  % AGREGACION
%datos_new_model_synt
m0 = (1-Eb)*cinf/(Eb*Co); %valor original (definición)
%m0=1.0e+03*9.1523;
%m0=1.0e+03*1.1523;

n0 = cinf*xi;
r0 = 1 + Co; % Kd=1 al inicio
x0=[m0; n0; r0];
lb=zeros(size(x0))+1e-6;
lb(3)=1+1e-6;
ub=inf*ones(size(x0));

% if traza_optimos==1
%    x0=x0_tmp';
% end

pop_x = x0'%[]%[0,0,0]%x0'%.*1509

%% TEST 1
%options = optimoptions('ga','PlotFcn',{@gaplotdistance,@gaplotrange,@gaplotbestf}, 'ConstraintTolerance',0.01,'MutationFcn',{@mutationgaussian,1,.5},'CreationFcn',{@gacreationnonlinearfeasible,'UseParallel',true,'NumStartPts',200});

%% TEST 2 con paralelismo y otros ajustes (ej. generación de espacio factible) - MUY VELOZ y en general con 100 genraciones ya se esta cerca del optimo
options = optimoptions('ga','CreationFcn', @gacreationnonlinearfeasible,'PlotFcns',{@gaplotdistance,@gaplotrange,@gaplotbestf},'UseParallel', true, 'UseVectorized', false,'MutationFcn',@mutacionAlta);

%% TEST 3 y TEST 4 en caso de usar población MATRIX base
%options = optimoptions('ga','CreationFcn', @gacreationnonlinearfeasible,'PlotFcns',{@gaplotdistance,@gaplotrange,@gaplotbestf},'UseParallel', true, 'UseVectorized', false,'MutationFcn',{@mutationgaussian,0.5,1});
%options = optimoptions('ga','InitialPopulationMatrix', pop_x,'PlotFcns',{@gaplotdistance,@gaplotrange,@gaplotbestf},'UseParallel', true, 'UseVectorized', false,'MutationFcn',{@mutationuniform,.99});

%% HIPER-PARAMETROS
options.Generations = 1000;
options.PopulationSize =100;
options.CrossoverFraction = 0.5;
options.ConstraintTolerance=0.01

% tic
%options.UseParallel = true;
% delete(gcp('nocreate'))
%parpool(24); % con 24 8 segundos menos... de 32 sec (aprox - 25% )
% toc

tic
%[x,fval]=lsqnonlin(@(x)fopt_2025(x,yIn,c0,h,tinyeccion,t),x0,lb,ub,options);

%% Llamada a metaheurística de Algoritmos Genéticos
[x,fval,exitflag,OO,Pop0,SS] = ga(@(x)fopt_2025_escalar(x,yIn,c0,nz,tinyeccion,t,tc),3,[],[],[],[],lb,ub,[],options) %deberia eliminar un []?

Xsalida = [Xsalida;x]  % AGREGACION

toc
%% En caso de querer analizar "población optima"
% for i=1:10
% x = Pop0(i,:)
% Grafico_Solution
% 
% %x = Pop0(5,:)
% %Grafico_Solution
% 
% end

% x = Pop0(43,:)
% Grafico_Solution
x = Pop0(1,:)
plot_sol(x,t,factor_tpo,tinyeccion,c0,nz,tc,yIn)
%save('Xsalida_vf_b1_primeras10.mat', 'Xsalida')
end  % AGREGACION


% x =
% 
%     4.8551    1.6852    1.3162

%% BD 2
% x =
% 
%     8.0812   20.0000    2.4056