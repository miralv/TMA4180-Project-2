function [x] = BFGS(mu,x0,epsilon,z,w,lambda_minbound,lambda_maxbound,max_iter)

steps=0;
H = eye(length(x0)); % initial approx. Hessian
I = eye(size(H0));
x=x0;  
gradient = eval_Pgrad(mu,x,z,w,lambda_minbound,lambda_maxbound); % tilda means: ignore output

    % Continue search until the descent is less than epsilon
    while (norm(gradient)> epsilon)&&(steps<max_iter)
        
        % Search directon
        p = -H*gradient;
        
        % Compute step length from backtracking
        alpha = linesearch(x,p,z,w,lambda_minbound,lambda_maxbound,mu);
        if (alpha == -1)
            alpha = 0;
            % sjekke dette - mulig sette p = -gradient og nytt søk.
        end
                
        % Update x-vector and gradient and store the previous ones
        x_prev = x;
        gradient_prev = gradient;
        x = x+alpha*p;
        gradient = eval_Pgrad(mu,x,z,w,lambda_minbound,lambda_maxbound);
   
        s = x-x_prev;
        y = gradient-gradient_prev;
         
        if s'*y > 1e-2 % need to discuss this value
            % If the angle between s and y is too close to 90 degrees, jump
            ro = 1/(transpose(y)*s);
            H = (I-ro*(s*transpose(y))) * H * (I-ro*(y*transpose(s))) + ro*(s*s.');
        else
            %H = I;
        end
        
        steps=steps+1;
    end % while
end % function

