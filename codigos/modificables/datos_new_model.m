function [datos, BSA, Hb, t_fin, isSynthetic]=datos_new_model(base_datos)
%% Por ahora, s�lo leemos el archivo "lys_ph5_abs.txt" (enviado por Gabriela el 30/04)
% BSA=1;
% Hb=0;
%load datos/lys_ph5_abs.txt
%datos=lys_ph5_abs;
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
        load datos/sal_7.txt
        datos  = sal_7;
        BSA    = 1;
        Hb     = 1;
        isSynthetic=false;
    case 8
        load datos/sal_8.txt
        datos  = sal_8;
        BSA    = 1;
        Hb     = 1;
        isSynthetic=false;
    case 9
        load datos/sal_9.txt
        datos  = sal_9;
        BSA    = 1;
        Hb     = 1;
        isSynthetic=false;
    case 10
        load datos/sal_10.txt
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
    case 1141
        BSA=1;
        Hb=0;
        load datos/curva_sintetica_41_b11.txt
        datos=curva_sintetica_41_b11;
        isSynthetic=true;
    case 24
        load ..datos//curvas_procesadas_b2/curva_11_centrada_suavizada.txt
        datos  = curva_11_centrada_suavizada;
        BSA    = 0;
        Hb     = 1;
        isSynthetic=true;
    case 243
        load ../datos/curva_08_solo_suavizada.txt
        datos  = curva_08_solo_suavizada;
        BSA    = 0;
        Hb     = 1;
        isSynthetic=true;
    otherwise
        error('base_datos desconocida');
end
t_fin  = datos(end,1);


% de b1: 31 y 71
%de b2: 31,4,43, 80, 57
%b11: 11,41, 71,50,61