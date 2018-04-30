function [eval,grad_f] = model_2eval(x,Z,w,n)
% A nxn symmetric matrix, filled up diagonally by the first n(n+1)/2 elements of x 
% c nx1 vector, last n elements of x
% Z nxm matrix with datapoints, where column i is datapoint nr i
% w correspoinding labels

%build A and b
[A,b] = build_A_vec(x,n);

nvar = n*(n+1)/2 + n;
m = length(w);
eval = 0; %function evaluation
residual = zeros(m,1); %store the residual values for calculating the gradient

for i = 1:m
    if w(i)>0
        residual(i) = max(Z(:,i)'*A*Z(:,i) + b'*Z(:,i) - 1,0);
        eval = eval + residual(i)^2;
    else
        residual(i) = max(1 - Z(:,i)'*A*Z(:,i) - b'*Z(:,i),0);
        eval = eval + residual(i)^2;
    end
end     

grad_r = zeros(m,nvar); % to hold the  dervatives of r_i
grad_f = zeros(nvar,1); % to hold the gradient of f
%fill gradient of r =[r_1^T,r_2^T,...,r_m^T]

for i = 1:m % observation number i; corresponds to column i in Z; Z(:,i)
    %find grad r_i(x)
    %if we have a residual, calculate gradient. If not, it is all zero, and
    %we don't have to do anything.
    if ((w(i)> 0)&& ~isInside(Z(:,i),b,A)) || ((w(i)<= 0)&& isInside(Z(:,i),b,A))
        
        %derivatives of the diagonal elements
        for j = 1:n
            grad_r(i,j)= (Z(j,i))^2;
        end
        
        %derivatives of the other elements in A
        %need to translate the coordinate from index in x to correspoinding
        %A(i,j): = a_i,a_j
        a_i = 2;
        a_j = 1;
        counter = 3;
        for j = n+1:nvar-n
            if a_i > n
                a_i = counter;
                a_j = 1;
                counter = counter + 1;
            end 
            % now a_i and a_j are the corresponding index in A
            grad_r(i,j) = 2*(Z(a_i,i))*(Z(a_j,i));
            a_i = a_i + 1;
            a_j = a_j + 1;
        end
        
        %derivativses of the elements in b
        j = nvar-n+1;
        grad_b = (Z(:,i))';
        grad_r(i,j:end)= grad_b;

    if w(i)< 0
            grad_r(i,:)= - grad_r(i,:);
    end
    grad_f = grad_f + 2 * residual(i).*grad_r(i,:)';
    end
end
end
    
function res = isInside(z_i,b,A)
res = 0;
if z_i'*A*z_i + b'*z_i <= 1
    res = 1;
end
end