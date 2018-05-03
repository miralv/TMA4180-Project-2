function [c] = c_vec(x, lambda_minbound, lambda_maxbound)
% Computes value of constaints
c(1) = x(1)-lambda_minbound;
c(2) = lambda_maxbound - x(1);
c(3) = x(2) - lambda_minbound;
c(4) = lambda_maxbound - x(2);
c(5) = sqrt(x(1)*x(2))-sqrt(lambda_minbound^2+x(3)^2);
end