% Calculates the gradient of the contraint-terms according to c_vec.m

function [grad] = c_grad(x, lambda_minbound, lambda_maxbound)
grad = zeros(5,1);
grad(1) = 1/(x(1) - lambda_minbound) - 1/(lambda_maxbound - x(1)) + x(2)/(2*sqrt(x(1)*x(2)));
grad(2) = 1/(x(2) - lambda_minbound) - 1/(lambda_minbound - x(2)) + x(1)/(2*sqrt(x(1)*x(2)));
grad(3) = -x(3)/sqrt(lambda_minbound^2+x(3)^2);

% grad(4) equals zero
% grad(5) equals zero
end