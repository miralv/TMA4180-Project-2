function [alpha] = linesearch(x,p,Z,w,c2,lambda_minbound,lambda_maxbound,mu) 
    
    alpha = 1; % initial steplength
    c1 = 1e-4; 
    amin = 0;
    amax = +inf;
    
    f = eval_P(x,Z,w,mu,lambda_minbound,lambda_maxbound);
    grad = eval_Pgrad(mu,x,Z,w,lambda_minbound, lambda_maxbound);
    
    % first, make sure that x + alpha*p is strictly feasible
    while ~isStrictlyFeasible(x+ alpha*p,lambda_minbound,lambda_maxbound)
        alpha = alpha/2;
    end
    f_new = eval_P(x + alpha*p,Z,w,mu,lambda_minbound,lambda_maxbound);
    grad_new = eval_Pgrad(mu,x+alpha*p,Z,w,lambda_minbound, lambda_maxbound);
  
    not_finished = 1;
    curvature_condition_in_use = 1;
    sufficient_decrease_in_use = 1;
    n_iter = 0;

    while not_finished
        if n_iter > 100 && n_iter < 200
            % continue without using the curvature condition.
            curvature_condition_in_use = 0;
        elseif n_iter > 200
            sufficient_decrease_in_use = 0;
        end
        if (~isStrictlyFeasible(x+ alpha*p,lambda_minbound,lambda_maxbound))
            amax = alpha;
            alpha = (amin + amax)/2;
            f_new = eval_P(x + alpha*p,Z,w,mu,lambda_minbound,lambda_maxbound);
            grad_new = eval_Pgrad(mu,x+alpha*p,Z,w,lambda_minbound, lambda_maxbound);
            n_iter = n_iter + 1;
        elseif (f_new > f + c1*alpha*grad.'*p)&&(sufficient_decrease_in_use) 
            amax = alpha;
            alpha = (amin + amax)/2;
            f_new = eval_P(x + alpha*p,Z,w,mu,lambda_minbound,lambda_maxbound);
            grad_new = eval_Pgrad(mu,x+alpha*p,Z,w,lambda_minbound, lambda_maxbound);
            n_iter = n_iter + 1;
        % Curvature condition
        elseif (grad_new.'*p< c2*grad.'*p)&&(curvature_condition_in_use) 
            amin = alpha;
            if (amax ==inf)
                alpha = 2*alpha;
            else
                alpha = (amin + amax)/2;
            end % if
            f_new = eval_P(x + alpha*p,Z,w,mu,lambda_minbound,lambda_maxbound);
            grad_new = eval_Pgrad(mu,x+alpha*p,Z,w,lambda_minbound, lambda_maxbound);
            n_iter = n_iter + 1;
        else
            if f_new < f && isStrictlyFeasible(x+ alpha*p,lambda_minbound,lambda_maxbound)
            not_finished = 0;
            else
                error('Loop is stuck')
            end
        end % if
    end % while
end % function