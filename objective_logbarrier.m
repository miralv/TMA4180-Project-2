function [f] = objective_logbarrier(A,b,Z,w,mu,llambda,ulambda)
% A nxn symmetric matrix, filled up diagonally by the first n(n+1)/2 elements of x 
% b nx1 vector, last n elements of x
% Z nxm matrix with datapoints, where column i is datapoint nr i
% w correspoinding labels

m = length(w);
f = 0; %function evaluation

for i = 1:m
    f = f + max((Z(:,i)'*A*Z(:,i) + b'*Z(:,i) - 1)*w(i),0);
    % Kompaktisert denne litt fra 2eval.m
    % Har bare ganget inn w(i) som sparer fire linjer med kode.
end
f = f - mu*log(A(1,1) - llambda);
f = f - mu*log(-A(1,1) + ulambda);
f = f - mu*log(A(2,2) - llambda);
f = f - mu*log(-A(2,2) - ulambda);
f = f - mu*log(A(1,1)*A(2,2)^(1/2) - (ulambda^2 + A(1,2)^2)^(1/2));

end