function [z,w,A,vec] = testproblems(n,dim,modelnumber)
    % Creates test problem
    
    % Generate a random, positive definite matrix and center point
    temp = rand(dim,dim,1)*0.2;
    A = (temp + temp.')/2;
    A = A + eye(dim)*dim;
    if modelnumber == 2
        % Run the non-elliptic true form
        A(2,2) = -A(2,2);
    end
    w = zeros(n,1);
    
   
    b = rand(dim,1)-0.5;
    vec = b;
    % n random generated vectors within (-.5,0.5)  
    z = (rand(dim,n,1)-0.5)*2.5;
    % Testing vector inclusion to assign w-value    
    for i = 1:n
        if ((z(:,i)'*A*(z(:,i))) + b'*z(:,i)) <= 1
            w(i)=1;
        else
            w(i)=-1;
        end %if    
    end %for
    
end % function

