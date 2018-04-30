function [x] = BFGS(x0,epsilon,z,w,dim)

c2 = 0.9;
steps=0;
H0 = eye(length(x0)); % initial approx. Hessian
I = eye(size(H0));
x=x0;
H=H0;
[~,gradient] = model_2eval(x,z,w,dim); % tilda means: ignore output

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
        [~,gradient] = model_2eval(x,z,w,dim);
   
        %Define s,y to compute Hessian
        s = x-x_prev;
        y = gradient-gradient_prev;

        % Compute Hessian
        ro = 1/(transpose(y)*s);
        H = (I-ro*(s*transpose(y))) * H * (I-ro*(y*transpose(s))) + ro*(s*s.');

        steps=steps+1;
    end % while
    disp(steps)
end % function

