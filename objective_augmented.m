function [f] = objective_augmented(A,b,Z,w,mu,llambda,ulambda)
% A nxn symmetric matrix, filled up diagonally by the first n(n+1)/2 elements of x 
% c nx1 vector, last n elements of x
% Z nxm matrix with datapoints, where column i is datapoint nr i
% w correspoinding labels

m = length(w);
f = 0; %function evaluation

for i = 1:m
    f = f + transpose(Z(:,i)'*A*Z(:,i) + b'*Z(:,i) - 1)*wi;
end
f = f + mu*(A(1,1) - llambda)^2;
f = f + mu*(-A(1,1) + ulambda)^2;
f = f + mu*(A(2,2) - llambda)^2;
f = f + mu*(-A(2,2) - ulambda)^2;
f = f + mu*(A(1,1)*A(2,2)^(1/2) - (ulambda^2 + A(1,2)^2)^(1/2))^2;

end