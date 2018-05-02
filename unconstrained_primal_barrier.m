% Hovedstrukturen til unconstrained primal barrier-metoden
% Status: Ikke kjørbart. BFGS må modifiseres og input må endres i henhold
% til unconstrained primal barrier.
% Algorithm 19.5, page 584

function [x] = unconstrained_primal_barrier(x0, z, w,lambda_minbound,lambda_maxbound, epsilon,max_iter)
    tau = 1;
    mu = 10;
    n_iter = 0;
    x = BFGS(mu,x0,tau,z,w,lambda_minbound,lambda_maxbound,max_iter);
    final_convergence = 0;
    while final_convergence == 0 
        tau = tau/2;
        mu = mu*0.1;
        x_new = BFGS(mu,x,tau,z,w,lambda_minbound,lambda_maxbound,max_iter);
        M = eval_Pgrad(mu,x_new,z,w,lambda_minbound, lambda_maxbound);
        %disp(norm(M))
        %disp(mu)
        if norm(M) < epsilon && mu < epsilon
            final_convergence = 1;
        end
        x = x_new;
        %plot_ellipsoid(z,w,x)
        % VIKTIG: choose new x: velger her den som tidligere ble funnet 
        
        n_iter = n_iter +1;
        
        %hvis ikke vi finner løsningen, prøver vi nytt tilfeldig startpunkt
        if n_iter > 30
            disp('not converged')
            tau = 1;
            mu = 1;
            [A_init, b_init] = initialGuess(lambda_minbound, lambda_maxbound);
            %Converting to single x
            x0 = convert_from_A(A_init,b_init);
            x = BFGS(mu,x0,tau,z,w,lambda_minbound,lambda_maxbound,max_iter); 
            n_iter = 0;
        end
    end
end