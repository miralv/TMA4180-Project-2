% Returns the value of the objective function using the log-barrier method.

function [f] = eval_P(A,b,Z,w,mu,lambda_minbound,lambda_maxbound)
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

x = convert_from_A(A,b);
c = c_vec(x,lambda_minbound,lambda_maxbound);
f = f - mu*log(c(1));
f = f - mu*log(c(2));
f = f - mu*log(c(3));
f = f - mu*log(c(4));
f = f - mu*log(c(5));
end