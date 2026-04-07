function out = local_feats(t, y)
% AUC
AUC = trapz(t, y);
% altura y tiempo de peak
[H, idx] = max(y);  Tpk = t(idx);
% FWHM
half = H/2;
% lado izq
li = find(y(1:idx) <= half, 1, 'last');
if ~isempty(li) && li < idx
    tL = interp1(y([li li+1]), t([li li+1]), half);
else
    tL = NaN;
end
% lado der
ri0 = find(y(idx:end) <= half, 1, 'first');
if ~isempty(ri0) && (idx+ri0-1) > idx
    r  = idx+ri0-1;
    tR = interp1(y([r-1 r]), t([r-1 r]), half);
else
    tR = NaN;
end
FWHM = tR - tL;
out = [AUC, H, Tpk, FWHM];
end
