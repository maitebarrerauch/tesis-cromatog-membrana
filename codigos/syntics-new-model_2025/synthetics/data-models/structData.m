dataStruct = load('merge-data-trace/matriz_curvas_b1_m.mat');
C_tmp = dataStruct.C;
t_tmp = dataStruct.t;
%Criterio selection: ej: por mayores areas de curvas max{I} ó I > 0.0 ó I > mean(I), 
% que tenga un significado "biotecnológico, mayor probabilidad de ser elution, etc.." la elección de metrica de "selección de curvas".
[salidaB1m,tB1m] = selectionCurves(C_tmp,t_tmp);

dataStruct = load('merge-data-trace/matriz_curvas_b1_n.mat');
C_tmp = dataStruct.C;
t_tmp = dataStruct.t;

%Criterio selection: ej: por mayores areas de curvas max{I} ó I > 0.0 ó I > mean(I), 
% que tenga un significado "biotecnológico, mayor probabilidad de ser elution, etc.." la elección de metrica de "selección de curvas".
[salidaB1n,tB1n] = selectionCurves(C_tmp,t_tmp);

dataStruct = load('merge-data-trace/matriz_curvas_b1_r.mat');
C_tmp = dataStruct.C;
t_tmp = dataStruct.t;
%Criterio selection: ej: por mayores areas de curvas max{I} ó I > 0.0 ó I > mean(I), 
% que tenga un significado "biotecnológico, mayor probabilidad de ser elution, etc.." la elección de metrica de "selección de curvas".
[salidaB1r,tB1r] = selectionCurves(C_tmp,t_tmp);

dataStruct = load('merge-data-trace/matriz_curvas_b2_m.mat');
C_tmp = dataStruct.C;
t_tmp = dataStruct.t;
%Criterio selection: ej: por mayores areas de curvas max{I} ó I > 0.0 ó I > mean(I), 
% que tenga un significado "biotecnológico, mayor probabilidad de ser elution, etc.." la elección de metrica de "selección de curvas".
[salidaB2m,tB2m] = selectionCurves(C_tmp,t_tmp);

dataStruct = load('merge-data-trace/matriz_curvas_b2_n.mat');
C_tmp = dataStruct.C;
t_tmp = dataStruct.t;
%Criterio selection: ej: por mayores areas de curvas max{I} ó I > 0.0 ó I > mean(I), 
% que tenga un significado "biotecnológico, mayor probabilidad de ser elution, etc.." la elección de metrica de "selección de curvas".
[salidaB2n,tB2n] = selectionCurves(C_tmp,t_tmp);

dataStruct = load('merge-data-trace/matriz_curvas_b2_r.mat');
C_tmp = dataStruct.C;
t_tmp = dataStruct.t;
%Criterio selection: ej: por mayores areas de curvas max{I} ó I > 0.0 ó I > mean(I), 
% que tenga un significado "biotecnológico, mayor probabilidad de ser elution, etc.." la elección de metrica de "selección de curvas".
[salidaB2r,tB2r] = selectionCurves(C_tmp,t_tmp);

dataStruct = load('merge-data-trace/matriz_curvas_b11_m.mat');
C_tmp = dataStruct.C;
t_tmp = dataStruct.t;
%Criterio selection: ej: por mayores areas de curvas max{I} ó I > 0.0 ó I > mean(I), 
% que tenga un significado "biotecnológico, mayor probabilidad de ser elution, etc.." la elección de metrica de "selección de curvas".
[salidaB11m,tB11m] = selectionCurves(C_tmp,t_tmp);

dataStruct = load('merge-data-trace/matriz_curvas_b11_n.mat');
C_tmp = dataStruct.C;
t_tmp = dataStruct.t;
%Criterio selection: ej: por mayores areas de curvas max{I} ó I > 0.0 ó I > mean(I), 
% que tenga un significado "biotecnológico, mayor probabilidad de ser elution, etc.." la elección de metrica de "selección de curvas".
[salidaB11n,tB11n] = selectionCurves(C_tmp,t_tmp);

dataStruct = load('merge-data-trace/matriz_curvas_b11_r.mat');
C_tmp = dataStruct.C;
t_tmp = dataStruct.t;
%Criterio selection: ej: por mayores areas de curvas max{I} ó I > 0.0 ó I > mean(I), 
% que tenga un significado "biotecnológico, mayor probabilidad de ser elution, etc.." la elección de metrica de "selección de curvas".
[salidaB11r,tB11r] = selectionCurves(C_tmp,t_tmp);

% Ejemplo de interpolar curva-data, out={new_interpolation,normalized_new_interpolation}
% N = 100 % observacion - menos puntos --> menor cómputo, menor precisión (hasta que pto.), es
%más optimo, la optimización es eficaz?
preProcesingCurve

analyticsCurves

% X_train = Datab11;
% figure;
% waterfall(X_train(:,:)');



%varNames = fieldnames(dataStruct);          % obtiene nombres de variables
% newNames = regexprep(varNames, 'p0_*(\d+)', 'P$1');
% numbers = cellfun(@(s) str2double(regexp(s,'\d+','match','once')), newNames');

% dataCell  = struct2cell(dataStruct);        % convierte cada variable en una celda
% dataCell ahora es un cell array donde cada celda tiene una variable del archivo
% Convertir a una gran matriz 3D (si todas son del mismo tamaño)
%dataMatrix = cat(3, dataCell{:});
%paramsMatrixSurf = reshape(dataMatrix, [numel(dataMatrix(:,:,1)), size(dataMatrix,3)]);
%paramsMatrixSurf = [single(paramsMatrixSurf);numbers];