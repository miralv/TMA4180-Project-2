
% START: DAMPING
%{
% Cholesky-dekomposisjon
L = chol(H);
u = eye(5)/L;
B = u*u';
%}
% END: DAMPING

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
       