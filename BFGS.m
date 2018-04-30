function [x] = BFGS(mu,x0,epsilon,z,w,lambda_minbound,lambda_maxbound)

theta = 10^-2;
c2 = 0.9;
steps=0;
H0 = eye(length(x0)); % initial approx. Hessian
I = eye(size(H0));
x=x0;
H=H0;  
gradient = eval_Pgrad(mu,x,z,w,lambda_minbound,lambda_maxbound); % tilda means: ignore output

% Cholesky-dekomposisjon
L = chol(H);
u = eye(5)/L;
B = u*u';

    % Continue search until the descent is less than epsilon
    while (norm(gradient)> epsilon)
        % Search directon
        p = -H*gradient;
        
        % Compute step length from linesearch method
        alpha = linesearch(x,p,z,w,c2,lambda_minbound,lambda_maxbound,mu);

        % Update x-vector and gradient and store the previous ones
        x_prev = x;
        gradient_prev = gradient;
        x = x+alpha*p;
        gradient = eval_Pgrad(mu,x,z,w,lambda_minbound,lambda_maxbound);
   
        %Define s,y to compute Hessian
        s = x-x_prev;
        y = gradient-gradient_prev;
        
        % Compute B, r for Damped BFGS
        r = theta*y + (1 - theta)*B*s; % Her er det B i stedet for H i boken. Vet ikke helt hvor B kommer fra
        if s'*y >= 0.2*s'*B*s
            theta = 1;
        else
            numerator = s'*B*s-s'*y;
            theta = 0.8*s'*B*s/numerator;
        end
        
        % Update B
        B = B - (B*(s*s')*B)/(s'*B*s) + (r*r')/(s'*r);
        
        % Cholesky-dekomposisjon
        L = chol(B);
        u = eye(5)/L;
        H = u*u';
        
        % Compute Hessian
        % ro = 1/(transpose(y)*s);
        % H = (I-ro*(s*transpose(y))) * H * (I-ro*(y*transpose(s))) + ro*(s*s.');

        steps=steps+1;
    end % while
    %disp(steps)
end % function

