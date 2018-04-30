function [z,w,A,vec] = testproblems(n,dim,error,modelnumber)
    
    failrate = 0.1; % misclassification rate
    
    % Generate a random, positive definite matrix and center point
    temp = rand(dim,dim,1)*0.2;
    A = (temp + temp.')/2;
    A = A + eye(dim)*dim;
    %A(2,2) = -A(2,2);
    w = zeros(n,1);
    
    if (modelnumber == 1)
        c = rand(dim,1)+0.5;
        vec = c;
        % n random generated vectors within (0,1)  
        x_y_min = -0.5*ones(dim,1);
        x_y_max = 2.5;
        z = rand(dim,n,1).*(x_y_max - x_y_min(1)) + x_y_min;
        % Testing vector inclusion to assign w-value    
        for i = 1:n
            if ((z(:,i)-c)'*A*(z(:,i)-c)) <= 1
                w(i)=1;
            else
                w(i)=-1;
            end %if    
        end %for
    else
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
        
    end %if
    
    % add misclassification to some z-vectors (noise in training set)
    if (error==1)
        failtotal = floor(failrate*n);
        labelswitch= randi(n,failtotal,1);
        for x = labelswitch
            w(x)=-w(x);
        end % for
    end % if     
    
end % function

