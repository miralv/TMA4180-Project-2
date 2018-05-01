function [alpha] = linesearch(x,p,Z,w,lambda_minbound,lambda_maxbound,mu) 
    % initial steplength
    alpha = 1; 
    c1 = 1e-4; 
    
    % Compute function ang gradient evaluation
    f = eval_P(x,Z,w,mu,lambda_minbound,lambda_maxbound);
    grad = eval_Pgrad(mu,x,Z,w,lambda_minbound, lambda_maxbound);
    
    % If we already have a feasible x + alpha*p, compute f_new
    if isStrictlyFeasible(x+ alpha*p,lambda_minbound,lambda_maxbound)
        f_new = eval_P(x + alpha*p,Z,w,mu,lambda_minbound,lambda_maxbound);
    end

    not_finished = 1;
    n_iter = 0;

    while not_finished
        if (~isStrictlyFeasible(x+ alpha*p,lambda_minbound,lambda_maxbound))
            % Ensures feasibility
            alpha = alpha*rho;
            f_new = eval_P(x + alpha*p,Z,w,mu,lambda_minbound,lambda_maxbound);
            n_iter = n_iter + 1;
        elseif (f_new > f + c1*alpha*grad.'*p)&& n_iter<50
            % Tries to fulfill the sufficient decrease condition
            alpha = alpha*rho;
            f_new = eval_P(x + alpha*p,Z,w,mu,lambda_minbound,lambda_maxbound);
            n_iter = n_iter + 1;
        else
            if f_new <= f && isFeasible(x+ alpha*p,lambda_minbound,lambda_maxbound)
                not_finished = 0;
            else
                %error('Loop is stuck')
                not_finished = 0;
            end
        end % if
    end % while
end % function