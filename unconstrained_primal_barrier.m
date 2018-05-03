function [x] = unconstrained_primal_barrier(x0, z, w,lambda_minbound,lambda_maxbound, epsilon,max_iter,modelnumber)
    % Find optimal soulution to the constrained problem by use of the
    % unconstrained primal barrier method
    tau = 1;
    mu = 10;
    n_iter = 0;
    x = BFGS(mu,x0,tau,z,w,lambda_minbound,lambda_maxbound,max_iter,modelnumber);
    final_convergence = 0;
    
    
    while final_convergence == 0 
        tau = tau*0.5;
        mu = mu*0.2;
        x_new = BFGS(mu,x,tau,z,w,lambda_minbound,lambda_maxbound,max_iter,modelnumber);
        M = eval_Pgrad(mu,x_new,z,w,lambda_minbound, lambda_maxbound);
        
        
        if norm(M) < epsilon && mu < epsilon
            %If KKT-conditons are fulfilled, terminate
            final_convergence = 1;
        end
        
        x = x_new;
        n_iter = n_iter +1;
        
        % If we do not have convergence, restart at a different start point
        if n_iter > 30
            disp('not converged')
            tau = 1;
            mu = 1;
            [A_init, b_init] = initialGuess(lambda_minbound, lambda_maxbound);
            x0 = convert_from_A(A_init,b_init);
            x = BFGS(mu,x0,tau,z,w,lambda_minbound,lambda_maxbound,max_iter,modelnumber); 
            n_iter = 0;
        end

    end
end