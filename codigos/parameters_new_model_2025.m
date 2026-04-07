% *** Par�metros fijos del problema ***

%% Par�metros de la matriz / columna
cinf       = 21/66000; % Capacidad m�xima de la columna (M) 
cinf = PM*cinf; % para pasar de molaridad (M) o mol/L a g/L se multiplica por PM
d          = 1.784;     % Di�metro de la columna (cm)
%d=6.8078;
L          = 0.4;       % Largo de la columna (cm)
Eb         = 0.947;     % Fracci�n de huecos de la columna () segun Yang Etzel 2003
Rp         = 3e-4/2;    % Radio del poro (cm) valor minimo segun Orr2013
dporo      = 3e4;     % Di�metro de macroporo de la part�cula de adsorbene (A)
Vloop      = 0.28;    % Volumen de las mangueras que conectan la columna al equipo (mL)

%% Necesarios para determinaci�n de Adimensionales
%[N,Ep,K,PM]=prop_proteinasB(BSA,Hb);

[Co, vlavado, Cosal, Cfsal, cv, F, vm]=operacion_new_model(base_datos);

Vol_col    = pi*(d^2/4)*L;        % Volumen de la columna (m^3)
v          = 4*F/(pi*d^2*Eb);     % Velocidad intersticial de la fase movil (m/s)
%% Par�metros de la fase m�vil
ro         = 0.99823; % Densidad (g/cm^3)
mu         = 0.01005; % Viscosidad (g/(cm*s))
%% C�lculo de n�meros adimensionales
%Dax         = 1.3e-10;              % diffusion coefficient of the solute, cm2 s-1 Yan Etzel 2003
Dax         = 1e-7;
%Dax=20e-2;
%keff        = 1e7 ;                 % mass-transfer coefficient in the liquid boundary layer, cm s-1 Yang Etzel 2003
%keff        = 1e2;
%keff=60;
keff=1e-3;
Pe          = L*v/Dax;
%nz=1.3e7;
ep         = 1/Pe; %par�metro num�rico para la resoluci�n de las ecuaciones
%% n0 = cinf*xi es el valor inicial del par�metro n que hay que ajustar
xi         = keff*(L/v)*(1-Eb)/Eb; 
%xi=(L/v)*(1-Eb)/Eb;
% valor de F para el nuevo modelo:
%xi=(1-Eb)/Eb;
%% Factores para adimensionar variables temporales y de concentraci�n
factor_tpo = L/v;
Coi        = Co./PM;                    % La concentraci�n m�xima de prote�nas equivale a su concentraci�n inicial
%% Adimensionamiento de variables temporales
tinyeccion = (vm/F)/factor_tpo;             % Tiempo adimensional de inyecci�n
t_igrad    = (vlavado+vm+Vloop+Vol_col)/F;  % Tiempo en el que empieza el gradiente
tgrad      = cv*Vol_col/F;                  % Tiempo de duraci�n del gradiente
%tlavado    = t_igrad/factor_tpo;            % Tiempo adimensional de lavado (antes de inicio del gradiente)
%telucion=t_igrad/factor_tpo; 
telucion=(tgrad+t_igrad)/factor_tpo;
%telucion   = tgrad/factor_tpo;              % Tiempo adimensional de duraci�n del gradiente
tlavado=tgrad/factor_tpo;
%tlavado    = (t_igrad)/factor_tpo;            % Tiempo adimensional de lavado (antes de inicio del gradiente)
tfin       = t_fin/factor_tpo;              % Tiempo adimensional al cual termina la cromatograf�a

%% Analizando la pertinencia de los calculos de tiempos de inyeccion, gradiente, elucion en relaci�n a los datos disponibles, ya que
%% tenemos mucha dependencia de aquello en el modelo matematico, y tal vez dichos tiempos son los que se deberian optimizar en el proceso,
%% es m�s es como una trampilla dichos calculos agregarlos al modelo?