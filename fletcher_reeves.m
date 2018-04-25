function [x] = fletcher_reeves(x0, epsilon, z, w, dim)
    
    c2 = 0.1;
    steps = 0;
    x = x0;
    
    % Starting value for gradient
    [~,gradient] = model_1eval(x,z,w,dim); 
    
    % Starting search directon
    p = -gradient;
    
    % Continue search until the descent is less than epsilon
    while (norm(gradient)> epsilon)
        
        % Store previous gradient
        gradient_prev = gradient;
        
        % Compute step length from linesearch method
        alpha = linesearch(x,p,z,w,dim,c2);
        
        % Update x-vector, gradient and beta
        x = x+alpha*p;
        [~,gradient] = model_1eval(x,z,w,dim);
        beta = transpose(gradient)*gradient/(transpose(gradient_prev)*gradient_prev);
        
        % Search directon
        p = -gradient+beta*p;
        
        steps = steps + 1;
    end 
    disp(steps)
end

