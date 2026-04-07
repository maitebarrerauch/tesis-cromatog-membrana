function F = extract_features(X, t)
% X: matriz [N x M] (cada columna = una curva)
% t: vector tiempo [N x 1] o empty -> usa indice 1..N
% F: [M x 4] columnas = [AUC, Altura, T_pico, FWHM]

if nargin < 2 || isempty(t)
    t = (1:size(X,1))';
end
M = size(X,2);
F = nan(M,4);

for k = 1:M
    y = X(:,k);
    % AUC (trapz en t)
    auc = trapz(t, y);
    % Altura
    [ymax, idx_max] = max(y);
    % Tiempo al pico (use t value)
    t_peak = t(idx_max);
    % FWHM: find half-max crossing points
    half = ymax/2;
    % find indices where signal crosses half level
    above = y >= half;
    if any(above)
        % contiguous region around the main peak: find first/last true around peak index
        % find left boundary
        left = idx_max;
        while left>1 && y(left)>=half
            left = left-1;
        end
        left = min(left+1, idx_max);
        % find right boundary
        right = idx_max;
        while right < length(y) && y(right) >= half
            right = right+1;
        end
        right = max(right-1, idx_max);
        % FWHM in units of t
        fwhm = t(right) - t(left);
    else
        fwhm = 0; % si no hay peaks
    end

    F(k,1) = auc;
    F(k,2) = ymax;
    F(k,3) = t_peak;
    F(k,4) = fwhm;
end
end
