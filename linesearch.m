function [alpha] = linesearch(x,p,Z,w,lambda_minbound,lambda_maxbound,mu) 
    % Compute alpha by backtracking linesearch
    alpha = 1; 
    c1 = 1e-4;
    rho = 1/2;
    not_finished = 1;
    n_iter = 0;
    
    % Compute values from previous x
    f = eval_P(x,Z,w,mu,lambda_minbound,lambda_maxbound);
    grad = eval_Pgrad(mu,x,Z,w,lambda_minbound, lambda_maxbound);


    while not_finished
        c = c_vec(x + alpha*p, lambda_minbound, lambda_maxbound);
        if (min(c)<0)&&n_iter<60
            % Ensures feasibility
            alpha = alpha*rho;
        elseif (eval_P(x + alpha*p,Z,w,mu,lambda_minbound,lambda_maxbound) > f + c1*alpha*grad.'*p)&& n_iter<60
            % Tries to fulfill the sufficient decrease condition
            alpha = alpha*rho;
        else
            if (min(c)<0)
                alpha = -1;
            end
            not_finished = 0;
        end% if
        n_iter = n_iter + 1;
    end% while
end % function