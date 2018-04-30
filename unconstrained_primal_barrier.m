% Hovedstrukturen til unconstrained primal barrier-metoden
% Status: Ikke kjørbart. BFGS må modifiseres og input må endres i henhold
% til unconstrained primal barrier.
% Algorithm 19.5, page 584

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