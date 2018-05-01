function res = isStrictlyFeasible(x,lambda_minbound,lambda_maxbound) %should take A has a parameter instead of building A every time
% return 1 if x is in the feasible region omega, 0 if not 
res = (x(1)-lambda_minbound>0) && (-x(1)+ lambda_maxbound >0) && (x(2)- lambda_minbound >0) && (-x(2) + lambda_maxbound >0) && (sqrt(x(1)*x(2)) - sqrt(lambda_minbound^2 + x(3)^2))> 0;
end