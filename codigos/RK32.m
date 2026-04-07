function u_new = RK32(u, dt, dx)
    k1 = -dt * LU_weno5_per_pato(u, dx);
    u1 = u + k1;

    k2 = -dt * LU_weno5_per_pato(u1, dx);
    u2 = 0.75 * u + 0.25 * (u1 + k2);

    k3 = -dt * LU_weno5_per_pato(u2, dx);
    u_new = (1/3) * u + (2/3) * (u2 + k3);
end
