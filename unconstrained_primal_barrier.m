% Hovedstrukturen til unconstrained primal barrier-metoden
% Status: Ikke kjørbart. BFGS må modifiseres og input må endres i henhold
% til unconstrained primal barrier.
% Algorithm 19.5, page 584

function [x] = unconstrained_primal_barrier(x0, z, w)
    dim = 2;
    tau = 1;
    mu = 1;
    x = BFGS(mu,x0,tau,z,w,dim);
    for i = 1:10
        tau = tau/2;
        mu = mu/2;
        x = BFGS(mu,x,tau,z,w,dim);
    end
end