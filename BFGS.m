function [x] = BFGS(mu,x0,epsilon,z,w,lambda_minbound,lambda_maxbound,max_iter)

%theta = 10^-2;
c2 = 0.9;
steps=0;
H0 = eye(length(x0)); % initial approx. Hessian
I = eye(size(H0));
x=x0;
H=H0;  
gradient = eval_Pgrad(mu,x,z,w,lambda_minbound,lambda_maxbound); % tilda means: ignore output
f_new = eval_P(x,z,w,mu,lambda_minbound,lambda_maxbound);
f = 0;
alpha = 1;
% START: DAMPING
%{
% Cholesky-dekomposisjon
L = chol(H);
u = eye(5)/L;
B = u*u';
%}
% END: DAMPING

    % Continue search until the descent is less than epsilon
    while (norm(gradient)> epsilon)&&(steps<max_iter)&&(alpha>1e-12)%(abs(f_new - f)>1e-12)
        % Search directon
        p = -H*gradient;
        
        % Compute step length from linesearch method
        alpha = linesearch(x,p,z,w,lambda_minbound,lambda_maxbound,mu);
        if (alpha == -1)
            alpha = 0;
            %disp('action')
        end
        f = f_new;
        f_new = eval_P(x+ alpha*p,z,w,mu,lambda_minbound,lambda_maxbound);
        % Check whether it is a descent
        %MÅ FINNE UT OM DETTE ER NØDVENDIG ETTER AT VI FJERNET DAMPING
        %if f > f_new
        %    p = -gradient;
        %    alpha = linesearch_v2(x,p,z,w,lambda_minbound,lambda_maxbound,mu);
            %fprintf('Norm(gradient: )%d',norm(gradient))
        %end

        if(~isStrictlyFeasible(x,lambda_minbound,lambda_maxbound))
            error('Vi er på utsiden av constraintsene!!!')
        end

        % Update x-vector and gradient and store the previous ones
        x_prev = x;
        gradient_prev = gradient;
        x = x+alpha*p;
        gradient = eval_Pgrad(mu,x,z,w,lambda_minbound,lambda_maxbound);
   
        s = x-x_prev;
        y = gradient-gradient_prev;
        
        % START: Damping
        %{
        % Compute B, r for Damped BFGS
        if s'*y >= 0.2*s'*B*s
            theta = 1;
        else
            numerator = s'*B*s-s'*y;
            theta = (0.8*s'*B*s)/numerator;
        end
        r = theta*y + (1 - theta)*B*s;
        
        % Update B
        %B = B - ((B*s)*(s'*B))/(s'*B*s) + (r*r')/(s'*r);
        
        % SKAL FJERNES ETTERHVERT: Test for om B er positiv-definitt.
        % Setter B til å være lik identitetsmatrisen hvis ikke.
        [~,a] = chol(B);
        if (a == 0 && rank(B) == size(B,1)) ~= 1
            B = eye(5);
            break
        end
        % Cholesky-dekomposisjon
        L = chol(B);
        u = eye(5)/L;
        H = u*u';
        %}
        % END: Damping
        % Compute Hessian
        
        if s'*y > 1e-12
            % If the angle between s and y is too close to 90 degrees, jump
            ro = 1/(transpose(y)*s);
            H = (I-ro*(s*transpose(y))) * H * (I-ro*(y*transpose(s))) + ro*(s*s.');
        else
            %H = I;
        end
        %disp(s'*y)
        steps=steps+1;
    end % while
    % disp(steps)
end % function
