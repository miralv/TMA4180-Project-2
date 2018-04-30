function [x] = BFGS(mu,x0,epsilon,z,w,dim)

theta = 10^-2;
c2 = 0.9;
steps=0;
H0 = eye(length(x0)); % initial approx. Hessian
I = eye(size(H0));
x=x0;
H=H0;
gradient = eval_Pgrad(mu,x,z,w,lambda_minbound,lambda_maxbound); % tilda means: ignore output

    % Continue search until the descent is less than epsilon
    while (norm(gradient)> epsilon)
        % Search directon
        p = -H*gradient;
        
        % Compute step length from linesearch method
        alpha = linesearch(x,p,z,w,dim,c2);

        % Update x-vector and gradient and store the previous ones
        x_prev = x;
        gradient_prev = gradient;
        x = x+alpha*p;
        gradient = eval_Pgrad(mu,x,z,w,lambda_minbound,lambda_maxbound);
   
        %Define s,y to compute Hessian
        B = 1/H;
        s = x-x_prev;
        y = gradient-gradient_prev;
        r = theta*y + (1 - theta)*B*s; % Her er det B i stedet for H i boken. Vet ikke helt hvor B kommer fra

        % Compute Hessian
        ro = 1/(transpose(y)*s);
        H = (I-ro*(s*transpose(y))) * H * (I-ro*(y*transpose(s))) + ro*(s*s.');

        steps=steps+1;
    end % while
    disp(steps)
end % function

