function [datos, BSA, Hb, t_fin]=datos_new_model(base_datos)
%% Por ahora, sólo leemos el archivo "lys_ph5_abs.txt" (enviado por Gabriela el 30/04)
% BSA=1;
% Hb=0;
% load datos/lys_ph5_abs.txt
% datos=lys_ph5_abs;
datos = []
switch base_datos
    case 1
        load data/datosbsa.txt
        datos  = datosbsa;
        BSA    = 1;
        Hb     = 0;
    case 2
        load data/datoshb.txt
        datos  = datoshb;
        BSA    = 0;
        Hb     = 1;
    case 3
        load data/sal_3.txt
        datos  = sal_3;
        BSA    = 1;
        Hb     = 1;
    case 4
        load data/sal_4.txt
        datos  = sal_4;
        BSA    = 1;
        Hb     = 1;
    case 5
        load data/sal_5.txt
        datos  = sal_5;
        BSA    = 1;
        Hb     = 1;
    case 6
        load data/sal_6.txt
        datos  = sal_6;
        BSA    = 1;
        Hb     = 1;
    case 7
        load data/sal_7.txt
        datos  = sal_7;
        BSA    = 1;
        Hb     = 1;
    case 8
        load data/sal_8.txt
        datos  = sal_8;
        BSA    = 1;
        Hb     = 1;
    case 9
        load data/sal_9.txt
        datos  = sal_9;
        BSA    = 1;
        Hb     = 1;
    case 10
        load data/sal_10.txt
        datos  = sal_10;
        BSA    = 1;
        Hb     = 1;
    case 11
        BSA=1;
        Hb=0;
        load data/lys_ph5_abs.txt   
        datos  = lys_ph5_abs;
end
t_fin  = datos(end,1);