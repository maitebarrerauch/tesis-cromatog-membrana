function yc = obtener_yc_rk2(tinyeccion,x,c0,nz,tc,t)
    c = solver_rk2_2025(tinyeccion,x,c0,nz,tc);
    I=zeros(1,length(t));
    for k =1:length(t)
        I(k)=find(tc==t(k));
    end
    yc=c(nz,I)';
end