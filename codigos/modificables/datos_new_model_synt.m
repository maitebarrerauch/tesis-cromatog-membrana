function [datos, BSA, Hb, t_fin, isSynthetic]=datos_new_model_synt(base_datos,position)
%% Por ahora, s�lo leemos el archivo "lys_ph5_abs.txt" (enviado por Gabriela el 30/04)
% BSA=1;
% Hb=0;
%load datos/lys_ph5_abs.txt
%datos=lys_ph5_abs;
%global X_Synt tNb11
switch base_datos
    case 1
        load ../datos/datosbsa.txt
        datos  = datosbsa
        BSA    = 1;
        Hb     = 0;
        isSynthetic=false;
    case 2
        load ../datos/datoshb.txt
        datos  = datoshb;
        BSA    = 0;
        Hb     = 1;
        isSynthetic=false;
    case 3
        load ../datos/sal_3.txt
        datos  = sal_3;
        BSA    = 1;
        Hb     = 1;
        isSynthetic=false;
    case 4
        load ../datos/sal_4.txt
        datos  = sal_4;
        BSA    = 1;
        Hb     = 1;
        isSynthetic=false;
    case 5
        load ../datos/sal_5.txt
        datos  = sal_5;
        BSA    = 1;
        Hb     = 1;
        isSynthetic=false;
    case 6
        load ../datos/sal_6.txt
        datos  = sal_6;
        BSA    = 1;
        Hb     = 1;
        isSynthetic=false;
    case 7
        load ../datos/sal_7.txt
        datos  = sal_7;
        BSA    = 1;
        Hb     = 1;
        isSynthetic=false;
    case 8
        load ../datos/sal_8.txt
        datos  = sal_8;
        BSA    = 1;
        Hb     = 1;
        isSynthetic=false;
    case 9
        load ../datos/sal_9.txt
        datos  = sal_9;
        BSA    = 1;
        Hb     = 1;
        isSynthetic=false;
    case 10
        load ../datos/sal_10.txt
        datos  = sal_10;
        BSA    = 1;
        Hb     = 1;
        isSynthetic=false;
    case 11
        BSA=1;
        Hb=0;
        load ../datos/lys_ph5_abs.txt
        datos=lys_ph5_abs;
        isSynthetic=false;
    case 1141 %base 11 curva 41
        BSA = 1; Hb = 0;
        load ../datos/curva_sintetica_41_b11.txt
        datos = curva_sintetica_41_b11;   % Nx2: [t_real, y_adim]
        isSynthetic = true;
    case 9999
    BSA = 1; 
    Hb = 0;
    % Cargar los archivos dentro de la función
    S_t = load('../datos/tNb11.mat');      % contiene la variable tNb11
    S_x = load('../datos/X_1peak_b11_37.mat');    % contiene la variable x_1peak

    tNb11   = S_t.tNb11;       
    X_1peak = S_x.X_1peak;        

    % Construir matriz datos
    datos = [tNb11', X_1peak(:, position)];

    isSynthetic = true;
    case 1000
    BSA = 1; 
    Hb = 0;
    % Cargar los archivos dentro de la función
    S_t = load('../datos/tNb2.mat');      % contiene la variable tNb11
    S_x = load('../datos/X_1peak_b2.mat');    % contiene la variable x_1peak

    tNb2   = S_t.tNb2;        
    X_1peak = S_x.X_1peak;        
    % Construir matriz datos
    datos = [tNb2', X_1peak(:, position)];

    isSynthetic = true;
    case 1001 %base 11 curvas sinteticas
        BSA = 1; 
        Hb = 0;
        % Cargar los archivos dentro de la función
        S_t = load('../datos/tNb11_vf.mat');      
        S_x = load('../datos/X_1peak_vf_b11_285c.mat');   
    
        tNb11   = S_t.tNb11;
        X_1peak = S_x.X_1peak;       
    
        % Construir matriz datos
        datos = [tNb11', X_1peak(:, position)];
    
        isSynthetic = true;

    case 1002 %base 2 curvas sinteticas
        BSA    = 0;       
        Hb     = 1;
        S_t = load('../datos/tNb2_797c.mat');      % contiene la variable tNb11
        S_x = load('../datos/X_1peak_b2_797c_vf.mat');    % contiene la variable x_1peak
    
        tNb2   = S_t.tNb2;          % acceder correctamente
        X_1peak = S_x.X_1peak;        % acceder correctamente
    
        % Construir matriz datos
        datos = [tNb2', X_1peak(:, position)];
        isSynthetic=true;
    
    otherwise
    error('base_datos desconocida');    
end
t_fin  = datos(end,1);
