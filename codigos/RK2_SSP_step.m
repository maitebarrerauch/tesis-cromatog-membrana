
% ===== RK2-SSP (Heun) para advección u_t + a u_x = 0
function u1 = RK2_SSP_step(u, dt, dx, a)
    k1 = -dt * LU_weno5_per(u, dx, a);     % F(u) = -L(u)
    uA = u + k1;
    k2 = -dt * LU_weno5_per(uA, dx, a);
    u1 = 0.5*u + 0.5*(uA + k2);
end
