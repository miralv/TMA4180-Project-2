% Hovedstrukturen til unconstrained primal barrier-metoden
% Status: Ikke kj�rbart. BFGS m� modifiseres og input m� endres i henhold
% til unconstrained primal barrier.
% Algorithm 19.5, page 584

function [x] = unconstrained_primal_barrier(x0, z, w,lambda_minbound,lambda_maxbound)
    tau = 1;
    mu = 100;
    x = BFGS(mu,x0,tau,z,w,lambda_minbound,lambda_maxbound);
    for i = 1:10
        tau = tau/2;
        mu = mu/2;
        x = BFGS(mu,x,tau,z,w,lambda_minbound,lambda_maxbound);
    end
end