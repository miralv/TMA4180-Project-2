function [x] = BFGS(mu,x0,epsilon,z,w,lambda_minbound,lambda_maxbound,max_iter,model_number)
steps=0;
H0 = eye(length(x0)); 
first_iteration = 1;
I = eye(size(H0));
x=x0;
H=H0;  
gradient = eval_Pgrad(mu,x,z,w,lambda_minbound,lambda_maxbound);


while (norm(gradient)> epsilon)&&(steps<max_iter)
    
        
    % Find search directon
    p = -H*gradient;
    if norm(p)>1e-6
        p = p/norm(p);
    end

    % Compute step length with backtracking linesearch
    alpha = linesearch(x,p,z,w,lambda_minbound,lambda_maxbound,mu);

    if (alpha == -1)
        alpha = 0; %this leads to the else-case in the other if
    end


    % Update x-vector and gradient and store the previous ones
    x_prev = x;
    gradient_prev = gradient;
    x = x+alpha*p;
    gradient = eval_Pgrad(mu,x,z,w,lambda_minbound,lambda_maxbound);
    s = x-x_prev;
    y = gradient-gradient_prev;

    if first_iteration
        %scale H according to the description on page 143 in
        %Nocedal&Wright
        H = transpose(y)*s/(transpose(y)*y) *I;
        first_iteration = 0;
    end

    if s'*y > 1e-12
        % If the angle between s and y is too close to 90 degrees, jump
        ro = 1/(transpose(y)*s);
        H = (I-ro*(s*transpose(y))) * H * (I-ro*(y*transpose(s))) + ro*(s*s.'); 
    else
        % If we have a problem with a non-elliptic true optimal
        % solution, reset to steepest descent
        if model_number == 2
            H = I;
        end
        % if not, H_k+1 = H_k
    end
    steps=steps+1;
end % while
end % function
