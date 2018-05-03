function [grad] = c_grad(x, lambda_minbound, lambda_maxbound)
% Gradient of log(c)

grad = zeros(5,1);

c = c_vec(x, lambda_minbound, lambda_maxbound);
grad(1) = 1/c(1) - 1/c(2) + x(2)/(2*sqrt(x(1)*x(2))*c(5));
grad(2) = 1/c(3) - 1/c(4) + x(1)/(2*sqrt(x(1)*x(2))*c(5));
grad(3) = -x(3)/(sqrt(lambda_minbound^2+x(3)^2)*c(5));
% grad(4) equals zero
% grad(5) equals zero

end