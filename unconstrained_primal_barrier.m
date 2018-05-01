% Hovedstrukturen til unconstrained primal barrier-metoden
% Status: Ikke kjørbart. BFGS må modifiseres og input må endres i henhold
% til unconstrained primal barrier.
% Algorithm 19.5, page 584

function [x] = unconstrained_primal_barrier(x0, z, w,lambda_minbound,lambda_maxbound, epsilon,max_iter)
    tau = 1;
    mu = 10;
    x = BFGS(mu,x0,tau,z,w,lambda_minbound,lambda_maxbound,max_iter);
    final_convergence = 0;
    while final_convergence == 0 && mu > 1e-12
        tau = tau/2;
        mu = mu*0.2;
        x_new = BFGS(mu,x,tau,z,w,lambda_minbound,lambda_maxbound,max_iter);
        M = eval_Pgrad(mu,x_new,z,w,lambda_minbound, lambda_maxbound);
        disp(norm(M))
        disp(mu)
        if norm(M) < epsilon && mu < epsilon
            final_convergence = 1;
        end
        x = x_new;
        %plot_ellipsoid(z,w,x)
        % VIKTIG: choose new x: velger her den som tidligere ble funnet 
    end
end