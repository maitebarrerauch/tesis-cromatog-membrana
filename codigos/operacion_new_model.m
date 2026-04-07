%c0m(1:nz+1,1)=(Cosal/10*Cfsal)*ones(nz+1,1);
function [Co, vlavado, Cosal, Cfsal, cv, F, vm]=operacion_new_model(base_datos)
%BSA pura para ajuste de parámetros
switch base_datos
    case 1	% lys pH 5
        Co      = 2;     % Concentración inicial de proteína (mg/mL).
        cv      = 10;      	% Largo del gradiente de sal (volumenes de columna).
        %cv=0.5;
        F       = 7.5;	% Flujo volumétrico de la fase móvil (mL/min).
        %F=3.5;
        vm      = 2;   % Volumen de inyección de la muestra (mL).
        vlavado = 15;       % Volumen de lavado (volumenes de columna).
        %vlavado=4.5;
%	PM	= 14300		% peso molecular lys
    case 2
        Co      = 0.989;    % concentración inicial de proteína (mg/mL). Se considera un 98.9% de pureza.
        cv      = 5.5;      % Largo del gradiente de sal (mL).
        F       = 0.1;      % Flujo volumétrico de la fase móvil (mL/min).
        vm      = 0.5;      % Volumen de inyección de la muestra (mL).
        vlavado = 2;        % Volumen de lavado (mL).
    case 3
        vm      = 0.5;
        Co      = 0.75;
        F       = 0.1;
        vlavado = 5;
        cv      = 7;
    case 4 
        vm      = 0.5;
        Co      = [0.75 0.95];
        F       = 0.13;
        vlavado = 5;
        cv      = 5.5;
    case 5
        vm      = 0.5;
        Co      = 1.3;
        F       = 0.13;
        vlavado = 5;
        cv      = 5.5;
    case 6
        vm      = 0.5;
        Co      = 0.7;
        F       = 0.13;
        vlavado = 5;
        cv      = 5.5;
    case 7
        vm      = 0.5;
        Co      = [0.9 1.2];
        F       = 0.1;
        vlavado = 2;
        cv      = 5.5;
    case 8
        vm      = 0.5;
        Co      = 0.75;
        F       = 0.1;
        vlavado = 2;
        cv      = 10;
    case 9
        vm      = 0.5;
        Co      = 0.9;
        F       = 0.5;
        vlavado = 2;
        cv      = 10;
    case 10
        vm      = 0.5;
        Co      = 1;
        F       = 0.1;
        vlavado = 2;
        cv      = 20;
    case 11	% lys pH 5
        Co      = 2;     % Concentración inicial de proteína (mg/mL).
        cv      = 10;      	% Largo del gradiente de sal (volumenes de columna).
        %cv=0.5;
        F       = 7.5;	% Flujo volumétrico de la fase móvil (mL/min).
        %F=3.5;
        vm      = 2;   % Volumen de inyección de la muestra (mL).
        vlavado = 15;       % Volumen de lavado (volumenes de columna).
        %vlavado=4.5;
%PM	= 14300		% peso molecular lys
    case 131	% lys pH 5
        Co      = 2;     % Concentración inicial de proteína (mg/mL).
        cv      = 10;      	% Largo del gradiente de sal (volumenes de columna).
        %cv=0.5;
        F       = 7.5;	% Flujo volumétrico de la fase móvil (mL/min).
        %F=3.5;
        vm      = 2;   % Volumen de inyección de la muestra (mL).
        vlavado = 15;
    case 101	% lys pH 5
        Co      = 2;     % Concentración inicial de proteína (mg/mL).
        cv      = 10;      	% Largo del gradiente de sal (volumenes de columna).
        %cv=0.5;
        F       = 7.5;	% Flujo volumétrico de la fase móvil (mL/min).
        %F=3.5;
        vm      = 2;   % Volumen de inyección de la muestra (mL).
        vlavado = 15;
    case 102	% lys pH 5
        Co      = 2;     % Concentración inicial de proteína (mg/mL).
        cv      = 10;      	% Largo del gradiente de sal (volumenes de columna).
        %cv=0.5;
        F       = 7.5;	% Flujo volumétrico de la fase móvil (mL/min).
        %F=3.5;
        vm      = 2;   % Volumen de inyección de la muestra (mL).
        vlavado = 15;
    case 171	% lys pH 5
        Co      = 2;     % Concentración inicial de proteína (mg/mL).
        cv      = 10;      	% Largo del gradiente de sal (volumenes de columna).
        %cv=0.5;
        F       = 7.5;	% Flujo volumétrico de la fase móvil (mL/min).
        %F=3.5;
        vm      = 2;   % Volumen de inyección de la muestra (mL).
        vlavado = 15;
    case 231
        Co      = 0.989;    % concentración inicial de proteína (mg/mL). Se considera un 98.9% de pureza.
        cv      = 5.5;      % Largo del gradiente de sal (mL).
        F       = 0.1;      % Flujo volumétrico de la fase móvil (mL/min).
        vm      = 0.5;      % Volumen de inyección de la muestra (mL).
        vlavado = 2;  
    case 24
        Co      = 0.989;    % concentración inicial de proteína (mg/mL). Se considera un 98.9% de pureza.
        cv      = 5.5;      % Largo del gradiente de sal (mL).
        F       = 0.1;      % Flujo volumétrico de la fase móvil (mL/min).
        vm      = 0.5;      % Volumen de inyección de la muestra (mL).
        vlavado = 2;  
    case 243
        Co      = 0.989;    % concentración inicial de proteína (mg/mL). Se considera un 98.9% de pureza.
        cv      = 5.5;      % Largo del gradiente de sal (mL).
        F       = 0.1;      % Flujo volumétrico de la fase móvil (mL/min).
        vm      = 0.5;      % Volumen de inyección de la muestra (mL).
        vlavado = 2;  
    case 280
        Co      = 0.989;    % concentración inicial de proteína (mg/mL). Se considera un 98.9% de pureza.
        cv      = 5.5;      % Largo del gradiente de sal (mL).
        F       = 0.1;      % Flujo volumétrico de la fase móvil (mL/min).
        vm      = 0.5;      % Volumen de inyección de la muestra (mL).
        vlavado = 2;  
    case 1002
        Co      = 0.989;    % concentración inicial de proteína (mg/mL). Se considera un 98.9% de pureza.
        cv      = 5.5;      % Largo del gradiente de sal (mL).
        F       = 0.1;      % Flujo volumétrico de la fase móvil (mL/min).
        vm      = 0.5;      % Volumen de inyección de la muestra (mL).
        vlavado = 2;  
    case 1150	% lys pH 5
        Co      = 2;     % Concentración inicial de proteína (mg/mL).
        cv      = 10;      	% Largo del gradiente de sal (volumenes de columna).
        %cv=0.5;
        F       = 7.5;	% Flujo volumétrico de la fase móvil (mL/min).
        %F=3.5;
        vm      = 2;   % Volumen de inyección de la muestra (mL).
        vlavado = 15;      
    case 116	% lys pH 5
        Co      = 2;     % Concentración inicial de proteína (mg/mL).
        cv      = 10;      	% Largo del gradiente de sal (volumenes de columna).
        %cv=0.5;
        F       = 7.5;	% Flujo volumétrico de la fase móvil (mL/min).
        %F=3.5;
        vm      = 2;   % Volumen de inyección de la muestra (mL).
        vlavado = 15;      
    case 1111	% lys pH 5
        Co      = 2;     % Concentración inicial de proteína (mg/mL).
        cv      = 10;      	% Largo del gradiente de sal (volumenes de columna).
        %cv=0.5;
        F       = 7.5;	% Flujo volumétrico de la fase móvil (mL/min).
        %F=3.5;
        vm      = 2;   % Volumen de inyección de la muestra (mL).
        vlavado = 15;      
    case 1141	% lys pH 5
        Co      = 2;     % Concentración inicial de proteína (mg/mL).
        cv      = 10;      	% Largo del gradiente de sal (volumenes de columna).
        %cv=0.5;
        F       = 7.5;	% Flujo volumétrico de la fase móvil (mL/min).
        %F=3.5;
        vm      = 2;   % Volumen de inyección de la muestra (mL).
        vlavado = 15;      
    case 1001 %9999 tambien	% lys pH 5
        Co      = 2;     % Concentración inicial de proteína (mg/mL).
        cv      = 10;      	% Largo del gradiente de sal (volumenes de columna).
        %cv=0.5;
        F       = 7.5;	% Flujo volumétrico de la fase móvil (mL/min).
        %F=3.5;
        vm      = 2;   % Volumen de inyección de la muestra (mL).
        vlavado = 15;      
    case 1000
        Co      = 0.989;    % concentración inicial de proteína (mg/mL). Se considera un 98.9% de pureza.
        cv      = 5.5;      % Largo del gradiente de sal (mL).
        F       = 0.1;      % Flujo volumétrico de la fase móvil (mL/min).
        vm      = 0.5;      % Volumen de inyección de la muestra (mL).
        vlavado = 2;   
    case 1003	% lys pH 5
        Co      = 2;     % Concentración inicial de proteína (mg/mL).
        cv      = 10;      	% Largo del gradiente de sal (volumenes de columna).
        %cv=0.5;
        F       = 7.5;	% Flujo volumétrico de la fase móvil (mL/min).
        %F=3.5;
        vm      = 2;   % Volumen de inyección de la muestra (mL).
        vlavado = 15;
end
Cosal = 0.05;           % Concentración inicial de sal (M).
Cfsal = 1;              % Concentración final de sal (M).