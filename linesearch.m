function [alpha] = linesearch(x,p,Z,w,lambda_minbound,lambda_maxbound,mu)

    % initial steplength
    alpha = 1; 
    c1 = 1e-4;
    rho = 1/2;
    not_finished = 1;
    n_iter = 0;

    % Compute function value and gradient
    f = eval_P(x,Z,w,mu,lambda_minbound,lambda_maxbound);
    grad = eval_Pgrad(mu,x,Z,w,lambda_minbound, lambda_maxbound);
    
    % If we already have a feasible x + alpha*p, compute a new f
    if isStrictlyFeasible(x+ alpha*p,lambda_minbound,lambda_maxbound)
        f_new = eval_P(x + alpha*p,Z,w,mu,lambda_minbound,lambda_maxbound);
    end

    while not_finished
        
        if (~isStrictlyFeasible(x+ alpha*p,lambda_minbound,lambda_maxbound))
            alpha = alpha*rho;
            f_new = eval_P(x + alpha*p,Z,w,mu,lambda_minbound,lambda_maxbound);
            n_iter = n_iter + 1;
        
         % Tries to fulfill the sufficient decrease condition
        elseif (f_new > f + c1*alpha*grad.'*p) && n_iter<50    
            alpha = alpha*rho;
            f_new = eval_P(x + alpha*p,Z,w,mu,lambda_minbound,lambda_maxbound);
            n_iter = n_iter + 1;
        
        else
            not_finished = 0;
            
            if ~ isStrictlyFeasible(x+ alpha*p,lambda_minbound,lambda_maxbound)
                alpha = -1;
            end
        end % if
    end % while
end % function





