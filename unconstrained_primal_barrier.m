function [x] = unconstrained_primal_barrier(x0, z, w)
    tau = 1;
    mu = 1;
    x = BFGS(x0,tau,z,w);
    for i = 1:10
        tau = tau/2;
        mu = mu/2;
        x = BFGS(x,tau,z,w);
    end
end

