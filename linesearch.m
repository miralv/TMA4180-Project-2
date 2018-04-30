function [alpha] = linesearch(x,p,z,w,dim,c2,lambda_minbound,lambda_maxbound) 
%dim er nå alltid lik, trenger deror ikke å ta det inn som argument

    alpha = 1; % initial steplength
    c1 = 1e-4; 
    amin = 0;
    amax = +inf;
    %[f,grad] = model_1eval(x,z,w,dim); %må oppdaters
    f = eval_P(x,Z,w,mu,lambda_minbound,lambda_maxbound);
    grad = eval_Pgrad(mu,x,z,w,lambda_minbound, lambda_maxbound);
    
    %[f_new,grad_new] = model_1eval(x+alpha*p,z,w,dim); %må oppdateres
    f_new = eval_P(A,b,Z,w,mu,lambda_minbound,lambda_maxbound);
    grad_new = eval_Pgrad(mu,x,z,w,lambda_minbound, lambda_maxbound);
    
    not_finished = 1
    % Get sufficient decrease AND make sure we are in feasible region
    while not_finished
        if (~isFeasible(x+ alpha*p,lambda_minbound,lambda_maxbound));
            alpha = (amin + amax)/2;
            [f_new,grad_new] = model_1eval(x+alpha*p,z,w,dim);
        elseif (f_new > f + c1*alpha*grad.'*p))
            amax = alpha;
            alpha = (amin + amax)/2;
            [f_new,grad_new] = model_1eval(x+alpha*p,z,w,dim);
        % Curvature condition
        elseif (grad_new.'*p< c2*grad.'*p) 
            amin = alpha;
            if (amax ==inf)
                alpha = 2*alpha;
            else
                alpha = (amin + amax)/2;
            end % if
            [f_new,grad_new] = model_1eval(x+alpha*p,z,w,dim);
        else
            % A feasible alpha satisfying sufficient decrease and curvature
            % condition is found
            not_finished = 0;
        end % if
    end % while
end % function