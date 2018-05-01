function [z,w,A,vec] = testproblems(n,dim,error,modelnumber)
    
    failrate = 0.1; % misclassification rate
    
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
        
  
    
    % add misclassification to some z-vectors (noise in training set)
    if (error==1)
        failtotal = floor(failrate*n);
        labelswitch= randi(n,failtotal,1);
        for x = labelswitch
            w(x)=-w(x);
        end % for
    end % if     
    
end % function

