
%datos = salidaB1m;
%% REvisar normalizacion del "tiempo" -- "Al optimizar"
tiempo = tB1m;
[b1m,nb1m,tNb1] = normaliza_curva(salidaB1m,tiempo,N);
[b1r,nb1r,tNb1] = normaliza_curva(salidaB1r,tiempo, N);
[b1n,nb1n,tNb1] = normaliza_curva(salidaB1n,tiempo, N);
tiempo = tB2m;
[b2m,nb2m,tNb2] = normaliza_curva(salidaB2m,tiempo, N);
[b2r,nb2r,tNb2] = normaliza_curva(salidaB2r,tiempo, N);
[b2n,nb2n,tNb2] = normaliza_curva(salidaB2n,tiempo, N);
tiempo = tB11m;
[b11m,nb11m,tNb11] = normaliza_curva(salidaB11m,tiempo, N);
[b11r,nb11r,tNb11] = normaliza_curva(salidaB11r,tiempo, N);
[b11n,nb11n,tNb11] = normaliza_curva(salidaB11n,tiempo, N);