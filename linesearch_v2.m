function [alpha] = linesearch_v2(x,p,Z,w,lambda_minbound,lambda_maxbound,mu) 
    
    alpha = 1; % initial steplength
    c1 = 1e-4; 
    amin = 0;
    amax = +inf;
    
    f = eval_P(x,Z,w,mu,lambda_minbound,lambda_maxbound);
    grad = eval_Pgrad(mu,x,Z,w,lambda_minbound, lambda_maxbound);
    
    if isStrictlyFeasible(x+ alpha*p,lambda_minbound,lambda_maxbound)
        f_new = eval_P(x + alpha*p,Z,w,mu,lambda_minbound,lambda_maxbound);
    end

    not_finished = 1;
    n_iter = 0;

    while not_finished
        if (~isStrictlyFeasible(x+ alpha*p,lambda_minbound,lambda_maxbound))
            amax = alpha;
            alpha = (amin + amax)/2;
            f_new = eval_P(x + alpha*p,Z,w,mu,lambda_minbound,lambda_maxbound);
            n_iter = n_iter + 1;
        elseif (f_new > f + c1*alpha*grad.'*p)&& n_iter<50
            amax = alpha;
            alpha = (amin + amax)/2;
            f_new = eval_P(x + alpha*p,Z,w,mu,lambda_minbound,lambda_maxbound);
            n_iter = n_iter + 1;
        else
            if f_new <= f && isFeasible(x+ alpha*p,lambda_minbound,lambda_maxbound)
                not_finished = 0;
            else
                disp(n_iter)
                disp(f_new)
                disp(f)
                disp(alpha)
                error('Loop is stuck')
            end
        end % if
    end % while
end % function