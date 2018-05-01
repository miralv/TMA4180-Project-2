% Hovedstrukturen til unconstrained primal barrier-metoden
% Status: Ikke kjørbart. BFGS må modifiseres og input må endres i henhold
% til unconstrained primal barrier.
% Algorithm 19.5, page 584

function [x] = unconstrained_primal_barrier(x0, z, w,lambda_minbound,lambda_maxbound, epsilon)
    tau = 1;
    mu = 10;
    x = BFGS(mu,x0,tau,z,w,lambda_minbound,lambda_maxbound);
    for i = 1:10
        tau = tau/2;
        mu = mu/2;
        x_new = BFGS(mu,x,tau,z,w,lambda_minbound,lambda_maxbound);
        if norm(x-x_new) < epsilon
            break
        end
        x = x_new;
        % VIKTIG: choose new x: velger her den som tidligere ble funnet 
    end
end